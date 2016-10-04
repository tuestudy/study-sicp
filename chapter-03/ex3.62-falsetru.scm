#lang racket

(require "stream-base-falsetru.scm")
(require "ex3.59b-falsetru.scm")
(require "ex3.60-falsetru.scm")
(require "ex3.61-falsetru.scm")

(define (scale-stream mul s)
  (stream-map (lambda (x) (* x mul)) s))

(define (invert-series s)
  (let ((c (stream-car s)))
    (scale-stream c
      (invert-unit-series (scale-stream (/ 1 c) s))
      )))

(define (div-series s1 s2)
  (if (= (stream-car s2) 0)
    (error 'div-series "denominator has a zero constant term")
    (mul-series s1 (invert-series s2))))

(define tangent-series (div-series sine-series cosine-series))

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

(define (sum xs)
  (foldr + 0 xs))
(define (calc-tan rad)
  (sum
    (stream-take
      (stream-map (lambda (t x) (* t (expt rad x)))
                  tangent-series
                  (integers-starting-from 0))
      100)))

(require rackunit)
(require rackunit/text-ui)

(define ex3.62-tests
  (test-suite
   "Test for ex3.62"

   (test-case
    ""
    (define s (cons-stream 1 (stream-map identity s)))
    (check-equal? (stream-take (div-series s s) 5) '(1 0 0 0 0))
    (check-equal? (stream-take (div-series (scale-stream 3 s) s) 5) '(3 0 0 0 0))
    (check-exn exn? (lambda () (div-series s (cons-stream 0 (stream-map identity s)))))
    (check-equal? (calc-tan 0) 0)
    (check-equal? (calc-tan (/ pi 4)) 1.0)
    )
   ))

(exit (run-tests ex3.62-tests))
