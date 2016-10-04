#lang racket

(require "stream-base-falsetru.scm")
(require "ex3.59a-falsetru.scm")

(provide
  cosine-series
  sine-series)

(define cosine-series
  (cons-stream 1 (integrate-series (stream-map - sine-series))))
(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))

(require rackunit)
(require rackunit/text-ui)

(define ex3.59b-tests
  (test-suite
   "Test for ex3.59b"

   (check-equal? (stream-take cosine-series 7) '(1 0 -1/2 0 1/24 0 -1/720))
   (check-equal? (stream-take sine-series 7) '(0 1 0 -1/6 0 1/120 0))
   ))

(run-tests ex3.59b-tests)
