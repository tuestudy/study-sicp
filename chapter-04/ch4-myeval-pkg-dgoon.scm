(load "../misc/myeval-helper.scm")
(load "../misc/local-table.scm")

(define (myeval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        (else
          (let ((op-impl (get 'myeval (operator exp))))
            (if op-impl
                (op-impl exp env)
                (myapply (myeval (operator exp) env)
                         (list-of-values (operands exp) env)))))))

(define (myapply procedure arguments)
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure procedure arguments))
        ((compound-procedure? procedure)
         (eval-sequence
          (procedure-body procedure)
          (extend-environment
           (procedure-parameters procedure)
           arguments
           (procedure-environment procedure))))
        (else
         (display "Unknown procedure type -- APPLY ")
         (display procedure)
         (newline))))

(define (install-myeval-package)
  (define (_quote exp env) (text-of-quotation exp))
  (define (_lambda exp env)
    (make-procedure (lambda-parameters exp)
            (lambda-body exp)
            env))
  (define (_begin exp env)
    (eval-sequence (begin-actions exp) env))
  (define (_cond exp env)
    (myeval (cond->if exp) env))
  (put 'myeval 'quote _quote)
  (put 'myeval 'set! eval-assignment)
  (put 'myeval 'define eval-definition)
  (put 'myeval 'if eval-if)
  (put 'myeval 'lambda _lambda)
  (put 'myeval 'begin _begin)
  (put 'myeval 'cond _cond))

(install-myeval-package)

; Copied from SRFI-23's sample (but not elegant) implementation
(define (error reason . args)
  (display "Error: ")
  (display reason)
  (for-each (lambda (arg) 
	      (display " ")
	      (write arg))
	    args)
  (newline)
  (scheme-report-environment -1))  ;; we hope that this will signal an error
