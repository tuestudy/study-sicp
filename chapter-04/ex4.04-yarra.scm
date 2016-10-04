(load "ch4-myeval-pkg-yarra.scm")
(load "../misc/scheme-test-r5rs.scm")

; eval-and, eval-or
(define (eval-and exp env)
  (define (iter operands env)
    (cond ((null? opearnds) true)
          ((true? (myeval (first-operand operands) env))
           (iter (rest-operands operands) env))
          (else false)))
  (iter (operands exp) env))

(define (eval-or exp env)
  (define (iter operands env)
    (cond ((null? operands) false)
          ((false? (myeval (first-operand operands) env))
           (iter (rest-operands operands) env))
          (else true)))
  (iter (operands exp) env))


; derivative and, or
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

; test
(define test-environment (setup-environment))
(myeval '(begin (define a 1) (define b 2)) test-environment)
(myeval '(begin (define c 1) (define d 2)) test-environment)

(display "TEST - ex4.04")(newline)
(run (make-testcase
      '(assert-false? (myeval '(and (= a 1) (= b 1)) test-environment))
      '(assert-true? (myeval '(and (= a 1) (= b 2)) test-environment))))

(run (make-testcase
      '(assert-false? (myeval '(or (= a 2) (= b 1)) test-environment))
      '(assert-true? (myeval '(or (= a 1) (= b 2)) test-environment))))