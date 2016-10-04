#lang racket

(require "stream-base-falsetru.scm")

(provide
  integrate-series)

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define (reciprocal x) (/ 1 x))

(define (integrate-series s)
  (stream-map * s (stream-map reciprocal integers)))

(require rackunit)
(require rackunit/text-ui)

(define ex3.59a-tests
  (test-suite
   "Test for ex3.59a"

   (test-case
    ""
    (define s
      (integrate-series
        (cons-stream 9 (cons-stream 8 (cons-stream 7 the-empty-stream)))))
    (check-equal? (stream-take s 3) '(9 4 7/3))
    )
   ))

(run-tests ex3.59a-tests)
