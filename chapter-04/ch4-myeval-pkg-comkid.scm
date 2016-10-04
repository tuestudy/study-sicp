(load "../misc/myeval-helper.scm")
(load "../misc/local-table.scm")

(load "ex4.04-comkid2.scm")
(load "ex4.05-comkid.scm")
(load "ex4.06-comkid.scm")
(load "ex4.07-comkid.scm")
(load "ex4.08-comkid.scm")
(load "ex4.09-comkid.scm")
(load "ex4.13-comkid.scm")

;
; myeval-package
;
(define (install-myeval-package)
  (define (text-of-quotation_ exp env) (text-of-quotation exp))
  (define (make-procedure_ exp env)
    (make-procedure 
     (lambda-parameters exp)
     (lambda-body exp)
     env))
  (define (eval-begin exp env)
    (eval-sequence (begin-actions exp) env))
  (define (eval-let exp env)
    (if (named-let? exp)
        (myeval (named-let->combination exp) env)
        (myeval (let->combination exp) env)))
  (define (eval-let* exp env)
    (myeval (let*->nested-lets exp) env))
  (define (eval-while exp env)
    (myeval (while->named-let exp) env))
  (define (eval-letrec exp env)
    (myeval (letrec->let exp) env))
  (put 'quote 'eval text-of-quotation_)
  (put 'set! 'eval eval-assignment)
  (put 'define 'eval eval-definition)
  (put 'if 'eval eval-if)
  (put 'lambda 'eval make-procedure_)
  (put 'begin 'eval eval-begin)
  (put 'cond 'eval eval-cond)
  (put 'and 'eval eval-and)
  (put 'or 'eval eval-or)
  (put 'let 'eval eval-let)
  (put 'let* 'eval eval-let*)
  (put 'while 'eval eval-while)
  (put 'letrec 'eval eval-letrec)
  (put 'make-unbound! 'eval eval-make-unbound!)
  'done)

(install-myeval-package)

;
; myapply
;
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

;
; myeval
;
(define (myeval exp env)
  (define (operator exp) (car exp))
  (define (operands exp) (cdr exp))
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        (else
         (let ((op (get (operator exp) 'eval)))
           (if op
               (op exp env)
               (myapply (myeval (operator exp) env)
                        (list-of-values (operands exp) env)))))))

