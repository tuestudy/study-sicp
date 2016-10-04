#lang racket

(require "stream-base-falsetru.scm")
(require "ex3.77-falsetru.scm")

(define (solve-2nd f dt y0 dy0)
  (define y (integral (delay dy) y0 dt))
  (define dy (integral (delay ddy) dy0 dt))
  (define ddy (stream-map f dy y))
  y)

(display (stream-take (solve-2nd (lambda (dy y) 1) 1 1 1) 10))
