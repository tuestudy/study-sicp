#lang racket

(require "stream-base-falsetru.scm")

(define (stream-enumerate-interval low high)
  (if (> low high)
    the-empty-stream
    (cons-stream
      low
      (stream-enumerate-interval (+ low 1) high))))

(define (display-line x)
  (display x)
  (newline))

(define (show x)
  (display-line x)
  x)

(require rackunit)
(require rackunit/text-ui)

(define ex3.51-tests
  (test-suite
   "Test for ex3.51"

    (test-case
     ""
     (display "define x\n")
     (define x
       (stream-map show (stream-enumerate-interval 0 10)))
     (display "stream-ref x 5\n")
     (check-equal? (stream-ref x 5) 5)
     (display "stream-ref x 7\n")
     (check-equal? (stream-ref x 7) 7))

   ))

(exit (run-tests ex3.51-tests))
