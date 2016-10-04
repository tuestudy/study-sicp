(load "../chapter-04/ex4.01-dgoon.scm")
(load "../misc/scheme-test-r5rs.scm")

;; Setup
(define test-environment (setup-environment))
(myeval '(begin (define a 1) (define b 2)) test-environment)
(myeval '(begin (define c 1) (define d 2)) test-environment)

;; Redefine myeval
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

(define (myeval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((and? exp) (eval-and exp env))
        ((or? exp) (eval-or exp env))
        ((and2? exp) (myeval (and->if exp) env))
        ((or2? exp) (myeval (or->if exp) env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (myeval (cond->if exp) env))
        ((application? exp)
         (myapply (myeval (operator exp) env)
                  (list-of-values (operands exp) env)))
        (else
         (error "Unknown expression type -- EVAL" exp))))

;;; Test for 'AND'
;(display "TEST for AND") (newline)
;(myeval '(and (= a 1) (= b 1)) test-environment)
;(myeval '(and (= a 1) (= b 2)) test-environment)
;(myeval '(and (= b 2) (begin (set! b 1) true)) test-environment)
;(myeval '(and (= a 2) (begin (set! a 2) true)) test-environment)
;(display (lookup-variable-value 'a test-environment)) (newline)
;(display (lookup-variable-value 'b test-environment)) (newline)

(display "TEST - ex4.04")(newline)
(run (make-testcase
      '(assert-false? (myeval '(and (= a 1) (= b 1)) test-environment))
      '(assert-true? (myeval '(and (= a 1) (= b 2)) test-environment))))

(run (make-testcase
      '(assert-false? (myeval '(and2 (= a 1) (= b 1)) test-environment))
      '(assert-true? (myeval '(and2 (= a 1) (= b 2)) test-environment))))

(run (make-testcase
      '(assert-false? (myeval '(or (= a 2) (= b 1)) test-environment))
      '(assert-true? (myeval '(or (= a 1) (= b 2)) test-environment))))

(run (make-testcase
      '(assert-false? (myeval '(or2 (= a 2) (= b 1)) test-environment))
      '(assert-true? (myeval '(or2 (= a 1) (= b 2)) test-environment))))
