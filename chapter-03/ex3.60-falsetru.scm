#lang racket

(require "stream-base-falsetru.scm")
(require "ex3.59b-falsetru.scm")
(provide
  mul-series)

(define (add-streams s1 s2)
  (stream-map + s1 s2))
(define (mul-series s1 s2)
  (cons-stream
    (* (stream-car s1) (stream-car s2))
    (add-streams
      (stream-map (lambda (x) (* (stream-car s1) x)) (stream-cdr s2))
      (mul-series (stream-cdr s1) s2)
      )))


(require rackunit)
(require rackunit/text-ui)

(define ex3.60-tests
  (test-suite
   "Test for ex3.60"

   (test-case
    "sin(x)*sin(x) + cos(x)+cos(x) = 1"
    (check-equal? 1 1)
    (define sine-sq+cosine-sq
      (add-streams
        (mul-series sine-series sine-series)
        (mul-series cosine-series cosine-series)))
    (check-equal? (stream-take sine-sq+cosine-sq 9) '(1 0 0 0 0 0 0 0 0))
    )
   ))

(run-tests ex3.60-tests)
