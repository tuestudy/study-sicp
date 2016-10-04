#lang racket

(require "stream-base-falsetru.scm")

(define (mul-streams s1 s2) (stream-map * s1 s2))

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

(define factorials
  (cons-stream 1 (mul-streams (integers-starting-from 2) factorials)))

(require rackunit)
(require rackunit/text-ui)

(define ex3.54-tests
  (test-suite
   "Test for ex3.54"

   (check-equal? (stream-ref factorials 0) 1)
   (check-equal? (stream-ref factorials 1) 2)
   (check-equal? (stream-ref factorials 2) 6)
   (check-equal? (stream-ref factorials 3) 24)
   (check-equal? (stream-ref factorials 4) 120)
   ))

(exit (run-tests ex3.54-tests))
