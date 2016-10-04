#lang racket

(require "stream-base-falsetru.scm")

(define (expand num den radix)
  (cons-stream
   (quotient (* num radix) den)
   (expand (remainder (* num radix) den) den radix)))

(require rackunit)
(require rackunit/text-ui)

(define ex3.58-tests
  (test-suite
   "Test for ex3.58"

   (test-case
    "expand 1 7 10"
    (define s (expand 1 7 10))
    (check-equal? (stream-take s 12) '(1 4 2 8 5 7 1 4 2 8 5 7)))

   (test-case
    "expand 3 8 10"
    (define s (expand 3 8 10))
    (check-equal? (stream-take s 12) '(3 7 5 0 0 0 0 0 0 0 0 0)))

   ))

(exit (run-tests ex3.58-tests))
