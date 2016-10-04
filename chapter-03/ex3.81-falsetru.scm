#lang racket

(require "stream-base-falsetru.scm")

(define (rand s i)
  (let ((x (if (number? (stream-car s)) (stream-car s) i)))
    (cons-stream x (rand (stream-cdr s) (rand-update x)))))

(define random-init 12345)
(define (random-numbers s)
  (rand s random-init))

(define rand-update add1)

(require rackunit)
(require rackunit/text-ui)

(define ex3.81-tests
  (test-suite
   "Test for ex3.81"

   (check-equal?
     (stream-take (random-numbers (list->stream '(x 5 x x 1 x x x))) 7)
     '(12345 5 6 7 1 2 3)
     )
   ))

(exit (run-tests ex3.81-tests))
