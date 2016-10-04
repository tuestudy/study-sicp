(load "../misc/myeval-helper.scm")
(load "../misc/local-table.scm")

; error procedure is defined only with Pretty Big language
(define (error msg var) 0)
; 4.04 solution
(define (eval-and exp env)
  (define (eval-and-internal operands)
    (if (null? operands) #t
        (let
          ((evaluated_next (myeval (car operands) env)))
          (if (not evaluated_next) #f
              (if (null? (cdr operands)) evaluated_next
                  (eval-and-internal (cdr operands)))))))
  (eval-and-internal (cdr exp)))

(define (make-not predicate) (list 'not predicate))
(define (and-if exp env)
  (if (null? exp) 'true
      (if (eq? (car exp) 'and) (and-if (cdr exp) env)  ; stripping and symbol
          (let ((eval_first (car exp)))
            (make-if
             (make-not eval_first)
             'false
             (if (null? (cdr exp)) eval_first
                 (and-if (cdr exp) env)))))))

(define (eval-or exp env)
  (define (eval-or-internal operands)
    (if (null? operands) #f
        (if (myeval (car operands) the-global-environment) #t
            (eval-or-internal (cdr operands)))))
  (eval-or-internal (cdr exp)))

(define (or-if exp env)
  (if (null? exp) 'false
      (if (eq? (car exp) 'or) (or-if (cdr exp) env)   ; stripping or symbol
          (make-if
           (car exp)
           'true
           (or-if (cdr exp) env)))))
; end of solution

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

(load "../misc/myeval-test.scm")

(run (make-testcase 
      '(assert-equal? #t (myeval '(and) the-global-environment))
      '(assert-equal? #f (myeval '(and false) the-global-environment))
      '(assert-equal? #t (myeval '(and true) the-global-environment))
      '(assert-equal? #f (myeval '(and true false) the-global-environment))
      '(assert-equal? #t (myeval '(and true true true) the-global-environment))
      '(assert-equal? 5 (myeval '(and true true true 5) the-global-environment))
      '(assert-equal? 2 (myeval '(and 5 3 true (- 5 3)) the-global-environment))
      '(assert-equal? #f (myeval '(and 5 3 true (- 5 3) false) the-global-environment))
      
      '(assert-equal? 2 (myeval (and-if '(and 5 3 true (- 5 3)) the-global-environment) the-global-environment))
      '(assert-equal? #f (myeval (and-if '(and 5 3 true (- 5 3) false) the-global-environment) the-global-environment))
      '(assert-equal? #f (myeval '(or) the-global-environment))
      '(assert-equal? #t (myeval '(or 1 2 3) the-global-environment))
      '(assert-equal? #f (myeval '(or false) the-global-environment))
      '(assert-equal? #f (myeval '(or false false) the-global-environment))
      '(assert-equal? #f (myeval '(or false false false) the-global-environment))
      '(assert-equal? #t (myeval '(or false false false true) the-global-environment))
      '(assert-equal? #t (myeval '(or false false (- 5 3) true) the-global-environment))
      
      '(assert-equal? #f (myeval (or-if '(or) the-global-environment) the-global-environment))
      '(assert-equal? #t (myeval (or-if '(or 1 2 3) the-global-environment) the-global-environment))
      '(assert-equal? #f (myeval (or-if '(or false) the-global-environment) the-global-environment))
      '(assert-equal? #f (myeval (or-if '(or false false) the-global-environment) the-global-environment))
      '(assert-equal? #f (myeval (or-if '(or false false false) the-global-environment) the-global-environment))
      '(assert-equal? #t (myeval (or-if '(or false false false true) the-global-environment) the-global-environment))
      '(assert-equal? #t (myeval (or-if '(or false false (- 5 3) true) the-global-environment) the-global-environment))
      ))