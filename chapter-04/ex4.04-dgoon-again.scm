(load "ex4.03-dgoon.scm")

;; Setup
(define test-environment (setup-environment))
(myeval '(begin (define a 1) (define b 2)) test-environment)
(myeval '(begin (define c 1) (define d 2)) test-environment)

(define (and? exp) (tagged-list? exp 'and))
(define (or? exp) (tagged-list? exp 'or))
(define (and2? exp) (tagged-list? exp 'and2))
(define (or2? exp) (tagged-list? exp 'or2))

(define (eval-and exp env)
  (define (iter operands env)
    ;    (display (first-operand operands))
    (cond ((null? operands) true)
          ((true? (myeval (first-operand operands) env))
           (iter (rest-operands operands) env))
          (else false)))
  ;  (display (operands exp))(newline)
  (iter (operands exp) env))

(define (eval-or exp env)
  (define (iter operands env)
    ;    (display (first-operand operands))
    (cond ((null? operands) false)
          ((false? (myeval (first-operand operands) env))
           (iter (rest-operands operands) env))
          (else true)))
  ;  (display (operands exp))(newline)
  (iter (operands exp) env))

(define (and->if exp)
  (define (iter operands)
    (if (null? operands) 
        'true
        (make-if (first-operand operands) (iter (rest-operands operands)) 'false)))
  (iter (operands exp)))

(define (or->if exp)
  (define (iter operands)
    (if (null? operands) 
        'false
        (make-if (first-operand operands) 'true (iter (rest-operands operands)))))
  (iter (operands exp)))

(define (install-and-or-package)
  (put 'myeval 'and eval-and)
  (put 'myeval 'and2 (lambda (exp env)
		       (eval-if (and->if exp)
				env)))
  (put 'myeval 'or eval-or)
  (put 'myeval 'or2 (lambda (exp env)
		      (eval-if (or->if exp)
			       env))))

(install-and-or-package)
