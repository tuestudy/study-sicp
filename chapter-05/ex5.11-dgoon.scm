(load "dgoon-simulator.scm")

;; b. (restore y) puts into y the last value saved on the stack, but only if that value was saved from y; otherwise, it signals an error. Modify the simulator to behave this way. You will have to change save to put the register name on the stack along with the value.

;; Redefine make-save and make-restore

(define (make-save inst machine stack pc)
  (let ((reg (get-register machine (stack-inst-reg-name inst))))
    (lambda ()
      ;(display "save:")(display (stack-inst-reg-name inst))(newline)
      (push stack (get-contents reg))
      (push stack (stack-inst-reg-name inst))
      (advance-pc pc))))

(define (make-restore inst machine stack pc)
  (let ((reg (get-register machine
			   (stack-inst-reg-name inst))))
    (lambda ()
      ;(display "restore:")(display (stack-inst-reg-name inst))(newline)
      (if (eq? (pop stack)
               (stack-inst-reg-name inst))
          (begin
            (set-contents! reg (pop stack))
            (advance-pc pc))
          (error "Register name mismatch!"))
  )))

;; c. (restore y) puts into y the last value saved from y regardless of what other registers were saved after y and not restored. Modify the simulator to behave this way. You will have to associate a separate stack with each register. You should make the initialize-stack operation initialize all the register stacks.

(define (make-save inst machine stack-table pc)
  (let ((reg (get-register machine (stack-inst-reg-name inst))))
    (lambda ()
      (let ((name (stack-inst-reg-name inst)))
	(let ((stack-entry (assoc name (machine 'stack)))) ; backward-patch for ex 5.13
	  (if stack-entry
	      (let ((stack (cadr stack-entry)))
		(push stack (get-contents reg))
		(advance-pc pc))
	      (error "There is no stack: " name)))))))

(define (make-restore inst machine stack-table pc)
  (let ((reg (get-register machine
			   (stack-inst-reg-name inst))))
    (lambda ()
      (let ((name (stack-inst-reg-name inst)))
	(let ((stack-entry (assoc name (machine 'stack)))) ; backward-patch for ex 5.13
	  (if stack-entry
	      (let ((stack (cadr stack-entry)))
		(set-contents! reg (pop stack))
		(advance-pc pc))
	      (error "Register name mismatch!")))))))

(define (make-new-machine)
  (display "Modified for Exercise 5.11-c by d-goon\n")
  (let ((pc (make-register 'pc))
        (flag (make-register 'flag))
        (stack-table '())
        (the-instruction-sequence '()))
    (let ((the-ops
           (list (list 'initialize-stack
                       (lambda ()
                         (map (lambda (stack-entry)
				(if stack-entry
				    ((cadr stack-entry) 'initialize)
				    '())))
			 stack-table))))
	  (register-table
           (list (list 'pc pc) (list 'flag flag))))
      (define (allocate-register name)
        (if (assoc name register-table)
            (error "Multiply defined register: " name)
	    (begin
	      (set! register-table
		    (cons (list name (make-register name))
			  register-table))
	      (set! stack-table
		    (cons (list name (make-stack))
			  stack-table))))
        'register-allocated)
      (define (lookup-register name)
        (let ((val (assoc name register-table)))
          (if val
              (cadr val)
              (error "Unknown register:" name))))
      (define (execute)
        (let ((insts (get-contents pc)))
          (if (null? insts)
              'done
              (begin
                ((instruction-execution-proc (car insts)))
                (execute)))))
      (define (dispatch message)
        (cond ((eq? message 'start)
               (set-contents! pc the-instruction-sequence)
               (execute))
              ((eq? message 'install-instruction-sequence)
               (lambda (seq) (set! the-instruction-sequence seq)))
              ((eq? message 'allocate-register) allocate-register)
              ((eq? message 'get-register) lookup-register)
              ((eq? message 'install-operations)
               (lambda (ops) (set! the-ops (append the-ops ops))))
              ((eq? message 'stack) stack-table)
              ((eq? message 'operations) the-ops)
              (else (error "Unknown request -- MACHINE" message))))
      dispatch)))
