#lang racket

(require "stream-base-falsetru.scm")
(require "ex3.77-falsetru.scm")

(define (RLC R L C dt)
  (define (RLC-aux Vc0 iL0)
    (define Vc (cons-stream Vc0 (integral (delay dVc) Vc0 dt)))
    (define iL (cons-stream iL0 (integral (delay diL) iL0 dt)))
    (define dVc (scale-stream iL (/ -1 C)))
    (define diL (add-streams (scale-stream Vc (/ L))
                             (scale-stream iL (/ (- R) L))))
    (stream-map list Vc iL))
  RLC-aux)

(display (stream-take ((RLC 1 1 0.2 0.1) 10 0) 10))
