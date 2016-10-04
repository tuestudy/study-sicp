#lang racket

(require "stream-base-falsetru.scm")
(require "ex3.60-falsetru.scm")
(provide
  invert-unit-series)

(define (invert-unit-series S)
  (define series
    (cons-stream 1 (mul-series (stream-map - (stream-cdr S)) series)))
  series)

(require rackunit)
(require rackunit/text-ui)

(define ex3.61-tests
  (test-suite
   "Test for ex3.61"

   (test-case
    ""
    (define s (cons-stream 1 s))
    (define s2 (invert-unit-series s))
    (define ivs (mul-series s s2))
    (check-equal? (stream-take ivs 9) '(1 0 0 0 0 0 0 0 0))
    )
   ))

(run-tests ex3.61-tests)
