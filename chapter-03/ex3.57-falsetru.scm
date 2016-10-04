#lang racket

(require "stream-base-falsetru.scm")

(define call-count 0)
(define (plus a b)
  (set! call-count (+ call-count 1))
  (+ a b))

(define (add-streams s1 s2)
  (stream-map plus s1 s2))

(define fibs
  (cons-stream 0
               (cons-stream 1
                            (add-streams (stream-cdr fibs)
                                         fibs))))

(set! call-count 0)
(printf "~a\n" (stream-ref fibs 10))

(printf "call-count = ~a\n" call-count) ; memoized-delay -> 9
                                        ; non-memoized-delay -> 221
