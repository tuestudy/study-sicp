#lang racket

(define no-op? empty?)
(define first-operand car)
(define rest-operands cdr)

(define (list-of-values-left-first exps env)
  (if (no-op? exps)
    '()
    (let ((x (eval-x (first-operand exps) env)))
      (cons x
            (list-of-values-left-first (rest-operands exps) env)))))

(define (list-of-values-right-first exps env)
  (if (no-op? exps)
    '()
    (let ((xs (list-of-values-right-first (rest-operands exps) env)))
      (cons (eval-x (first-operand exps) env)
            xs))))

(define evaluated '())
(define (eval-x x env)
  (begin
    (set! evaluated (append evaluated (list x)))
    x))


(require rackunit)
(require rackunit/text-ui)

(define list-of-values-tests
  (test-suite
   "Test for list-of-values"

   (test-case
    "left first"
    (set! evaluated '())
    (define dummy-env '())
    (check-equal? (list-of-values-left-first '(1 2 3) dummy-env) '(1 2 3))
    (check-equal? evaluated '(1 2 3))
    )

   (test-case
    "right first"
    (set! evaluated '())
    (define dummy-env '())
    (check-equal? (list-of-values-right-first '(1 2 3) dummy-env) '(1 2 3))
    (check-equal? evaluated '(3 2 1))
    )
   ))

(exit (run-tests list-of-values-tests))
