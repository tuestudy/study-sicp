(load "ex5.12-dgoon.scm")
(define (make-machine register-names ops controller-text)
  (let ((machine (make-new-machine)))
    ; <----- COMMENT OUT!
    ;(for-each (lambda (register-name)
    ;            ((machine 'allocate-register) register-name))
    ;          register-names)
    ; ----->
    ((machine 'install-operations) ops)    
    ((machine 'install-instruction-sequence)
     (assemble controller-text machine))
    machine))

(define (make-new-machine)
  ;(display "Copied from Exercise 5.12 and Modified for Exercise 5.13 by d-goon\n")
  (let ((pc (make-register 'pc))
        (flag (make-register 'flag))
	(instruction-set '()) ; ex 5.12
	(point-register-set '()) ; ex 5.12
	(stack-register-set '()) ; ex 5.12
	(register-source-set '()) ; ex 5.12
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
	      ;(error "Unknown register:" name)))) ; COMMENT OUT!
	      (begin
		;(display "Allocate register and stack for ")(display name)(newline)
		(allocate-register name) ; ex 5.13
		(cadr (assoc name register-table)))))) ; ex 5.13
      
      (define (execute)
        (let ((insts (get-contents pc)))
          (if (null? insts)
              'done
              (begin
                ((instruction-execution-proc (car insts)))
                (execute)))))
      
      (define (log-instruction inst)
	(let ((entry (assoc (instruction-text inst)
			    instruction-set)))
	  (if entry
	      '()
	      (begin
		;(display "Log-instruction:")
		;(display (car inst))(newline)
		(set! instruction-set
		      (cons (list (instruction-text inst) 'occurred)
			    instruction-set))))))

      (define (log-register-source inst)
	(let ((reg (cadr inst))
	      (src (caddr inst)))
	  (let ((key (list reg src)))
	    (let ((entry (assoc key register-source-set)))
	      (if entry
		  '()
		  (begin
		    ;(display "Log-register-source:");(display key)(newline)
		    (set! register-source-set
			  (cons (list key '())
				register-source-set))))))))

      (define (log-point-register inst)
	(if (eq? (caadr inst) 'reg)
	    (let ((reg (cadadr inst)))
	      (let ((entry (assoc reg point-register-set)))
		(if entry
		    '()
		    (begin
		      ;(display "Log-point-register:");(display reg)(newline)
		      (set! point-register-set
			    (cons (list reg 'point)
				  point-register-set))))))))

      (define (log-stack-register inst)
	(let ((reg (cadr inst)))
	  (let ((entry (assoc reg stack-register-set)))
	    (if entry
		'()
		(begin
		  ;(display "Log-stack-register:");(display reg)(newline)
		  (set! stack-register-set
			(cons (list reg 'stack)
			      stack-register-set)))))))
      
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
	      ((eq? message 'log-instruction) log-instruction) ; ex 5.12
	      ((eq? message 'log-point-register) log-point-register) ; ex 5.12
	      ((eq? message 'log-stack-register) log-stack-register) ; ex 5.12
	      ((eq? message 'log-register-source) log-register-source) ; ex 5.12
	      ((eq? message 'instruction-set) instruction-set) ; ex 5.12
	      ((eq? message 'point-register-set) point-register-set) ; ex 5.12
	      ((eq? message 'stack-register-set) stack-register-set) ; ex 5.12
	      ((eq? message 'register-source-set) register-source-set) ; ex 5.12
              ((eq? message 'operations) the-ops)
              (else (error "Unknown request -- MACHINE" message))))
      dispatch)))

(display "Ex5.13 with dgoon-fib.scm")(newline)
(load "dgoon-fib.scm")
(set-register-contents! fib-machine 'n 10)
(start fib-machine)
(display "fib(10) -> ")(display (get-register-contents fib-machine 'val))(newline)
