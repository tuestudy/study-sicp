#lang racket

(require "stream-base-falsetru.scm")
(require "ex3.70-falsetru.scm")

(define (find-consecutive s)
  (define (consecutive-aux s prev)
    (if (equal? (stream-car s) prev)
      (cons-stream prev (consecutive-aux (stream-cdr s) prev))
      (consecutive-aux (stream-cdr s) (stream-car s))))
  (consecutive-aux s false))

(define (cube x) (* x x x))
(define (pair-cube-sum x) (+ (cube (car x)) (cube (cadr x))))
(define candidates (stream-map pair-cube-sum (weighted-pairs integers integers pair-cube-sum)))
(define Ramanujan-numbers (find-consecutive candidates))

(require rackunit)
(require rackunit/text-ui)

(define ex3.71-tests
  (test-suite
   "Test for ex3.71"

   (check-equal? (stream-car Ramanujan-numbers) 1729)
   (check-equal? (stream-take Ramanujan-numbers 5) '(1729 4104 13832 20683 32832))
   ))

(exit (run-tests ex3.71-tests))
