#lang racket

(require "stream-base-falsetru.scm")

(define (add-streams s1 s2)
  (stream-map + s1 s2))

(require rackunit)
(require rackunit/text-ui)

(define ex3.53-tests
  (test-suite
   "Test for ex3.53"

   (test-case
    ""
    (define s (cons-stream 1 (add-streams s s)))
    (check-equal? (stream-ref s 0) 1)
    (check-equal? (stream-ref s 1) 2)
    (check-equal? (stream-ref s 2) 4)
    (check-equal? (stream-ref s 3) 8)
    )
   ))

(exit (run-tests ex3.53-tests))
