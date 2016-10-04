#lang racket


(require "stream-base-falsetru.scm")

(define (scale-stream s mul)
  (stream-map (lambda (x) (* x mul)) s))
(define (integral integrand initial-value dt)
  (define int
    (cons-stream initial-value
                 (add-streams (scale-stream integrand dt)
                              int)))
  int)


(define (RC R C dt)
  (define (f i v0)
    (cons-stream v0
                 (add-streams (scale-stream i R)
                              (integral (scale-stream i (/ 1 C)) v0 dt)))
    )
  f)

(define RC1 (RC 5 1 0.5))
(define constant-currents (cons-stream 1 constant-currents))
(for-each
  (lambda (x) (printf "~a\n" x))
  (stream-take (RC1 constant-currents 110) 10)
  )
