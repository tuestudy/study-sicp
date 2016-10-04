(load "../misc/local-table.scm")
(load "../misc/myeval-helper.scm")

(define (install-myeval-package)
  (define (make-procedure_ exp env)
    (make-procedure 
     (lambda-parameters exp)
     (lambda-body exp)
     env))
  (define (eval-begin exp env)
    (define (begin-actions exp) (cdr exp))
    (eval-sequence (begin-actions exp) env))
  (define (eval-if exp env)
    (if (true? (myeval (if-predicate exp) env))
        (myeval (if-consequent exp) env)
        (myeval (if-alternative exp) env)))
  (define (text-of-quotation_ exp env) (text-of-quotation exp))
  (define (eval-cond exp env)
    (myeval (cond->if exp) env))

  (put 'quote 'eval text-of-quotation_)
  (put 'set! 'eval eval-assignment)
  (put 'define 'eval eval-definition)
  (put 'if 'eval eval-if)
  (put 'lambda 'eval make-procedure_)
  (put 'begin 'eval eval-begin)
  (put 'cond 'eval eval-cond)
  'done)

(install-myeval-package)

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
         (error
          "Unknown procedure type -- APPLY" procedure))))

(define (myeval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        (else
         (let ((op (get (operator exp) 'eval)))
           (if op
               (op exp env)
               (myapply (myeval (operator exp) env)
                        (list-of-values (operands exp) env)))))))

(load "../misc/myeval-test.scm")