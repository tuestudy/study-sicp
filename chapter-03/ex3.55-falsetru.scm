#lang racket

(require "stream-base-falsetru.scm")

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define (partial-sums s)
  (define result
    (cons-stream
      (stream-car s)
      (add-streams result (stream-cdr s))))
  result)

;(define (partial-sums s)
;  (define (partial-sums-aux s acc)
;    (cons-stream acc (partial-sums-aux (stream-cdr s) (+ (stream-car s) acc))))
;  (partial-sums-aux (stream-cdr s) (stream-car s)))

;(define (partial-sums s)
;  (define (partial-sums-aux s acc)
;    (cons-stream (+ acc (stream-car s)) (partial-sums-aux (stream-cdr s) (+ (stream-car s) acc))))
;  (partial-sums-aux s 0))

(require rackunit)
(require rackunit/text-ui)

(define ex3.55-tests
  (test-suite
   "Test for ex3.55"

   (test-case
    ""
    (define s (partial-sums integers))
    (check-equal? (stream-ref s 0) 1)
    (check-equal? (stream-ref s 1) 3)
    (check-equal? (stream-ref s 2) 6)
    (check-equal? (stream-ref s 3) 10)
    (check-equal? (stream-ref s 4) 15)
    )
   ))

(exit (run-tests ex3.55-tests))
