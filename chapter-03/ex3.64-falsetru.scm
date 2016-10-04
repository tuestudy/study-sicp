#lang racket

(require "stream-base-falsetru.scm")


(define (square x) (* x x))

(define (average a b)
  (/ (+ a b) 2))

(define (sqrt-improve guess x)
  (average guess (/ x guess)))

(define (sqrt-stream x)
  (define guesses
    (cons-stream 1.0
                 (stream-map (lambda (guess)
                               (sqrt-improve guess x))
                             guesses)))
  guesses)

(define (delta a b)
  (abs (- a b)))

(define (stream-limit s tolerance)
  (let ((x1 (stream-car s))
        (x2 (stream-car (stream-cdr s))))
    (if (< (delta x1 x2) tolerance)
      x2
      (stream-limit (stream-cdr s) tolerance))))

(define (sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))

(require rackunit)
(require rackunit/text-ui)

(define tolerance 0.0001)
(define ex3.64-tests
  (test-suite
   "Test for ex3.64"

   (check-true (< (delta (sqrt 25 tolerance) 5) tolerance))
   (check-true (< (delta (sqrt 9 tolerance) 3) tolerance))
   (check-true (< (delta (sqrt 4 tolerance) 2) tolerance))
   ))

(exit (run-tests ex3.64-tests))
