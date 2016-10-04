(load "../misc/myeval-helper.scm")
(load "../misc/local-table.scm")
(load "../misc/scheme-test-r5rs.scm")

(define (eval-and_ exp env)
  (define (iter ps last-value)
    (cond ((null? ps) last-value)
          ((false? last-value) false)
          (else
           (iter (cdr ps) (myeval (car ps) env)))))
  (if (null? (cdr exp))
      true
      (iter (cdr exp) true)))

(define (make-not predicate) (list 'not predicate))
(define (and->if exp env)
  (if (null? exp)
      'true
      (if (eq? (car exp) 'and) 
          (and->if (cdr exp) env)
          (let ((eval_first (car exp)))
            (make-if
             (make-not eval_first)
             'false
             (if (null? (cdr exp)) 
                 eval_first
                 (and->if (cdr exp) env)))))))

;(define (and->if exp)
;  (if (false? (car exp))
;      false
;      (make-if (null? (cdr exp))
;               (car exp)
;               (and->if (cdr exp)))))

(define (eval-and exp env)
  (if (null? (cdr exp))
      true
      (myeval (and->if exp env) env)))


(define (eval-or exp env)
  (define (iter ps last-value)
    (cond ((null? ps) last-value)
          ((true? last-value) last-value)
          (else
           (iter (cdr ps) (myeval (car ps) env)))))
  (if (null? (cdr exp))
      false
      (iter (cdr exp) false)))


(define (install-myeval-package)
  (define (text-of-quotation_ exp env) (text-of-quotation exp))
  (define (make-procedure_ exp env)
    (make-procedure 
     (lambda-parameters exp)
     (lambda-body exp)
     env))
  (define (eval-begin exp env)
    (eval-sequence (begin-actions exp) env))  
  (define (eval-cond exp env)
    (myeval (cond->if exp) env))
  (put 'quote 'eval text-of-quotation_)
  (put 'set! 'eval eval-assignment)
  (put 'define 'eval eval-definition)
  (put 'if 'eval eval-if)
  (put 'lambda 'eval make-procedure_)
  (put 'begin 'eval eval-begin)
  (put 'cond 'eval eval-cond)
  (put 'and 'eval eval-and)
  (put 'or 'eval eval-or)
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

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

;(load "../misc/myeval-test.scm")
(define the-global-environment (setup-environment))
(run (make-testcase
      ; and
      '(assert-equal? true (myeval '(and) the-global-environment))
      '(assert-equal? 1 (myeval '(and 1) the-global-environment))
      '(assert-equal? false (myeval '(and false) the-global-environment))
      '(assert-equal? 3 (myeval '(and 1 3) the-global-environment))
      '(assert-equal? 6 (myeval '(and 1 3 4 6) the-global-environment))
      '(assert-equal? false (myeval '(and 1 3 4 6 false) the-global-environment))
      ; or
      ;'(assert-equal? false (myeval '(or) the-global-environment))
      ;'(assert-equal? 1 (myeval '(or 1) the-global-environment))
      ;'(assert-equal? 3 (myeval '(or 3 1 2 3 false) the-global-environment))
      ;'(assert-equal? 5 (myeval '(or false false false false 5) the-global-environment))
      ))