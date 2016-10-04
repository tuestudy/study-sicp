#lang racket

(require "stream-base-falsetru.scm")

(define (pairs s t)
  (interleave
   (stream-map (lambda (x) (list (stream-car s) x))
               t)
   (pairs (stream-cdr s) (stream-cdr t))))

(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (interleave s2 (stream-cdr s1)))))

(define (stream-idx s x)
  (if (equal? (stream-car s) x)
    0
    (+ (stream-idx (stream-cdr s) x) 1)))

(define (guess-int-pairs-idx a b)
  (if (= a b)
    (- (expt 2 a) 2)
    (+ (- (* (expt 2 a) (- b a)) (expt 2 (- a 1))) (guess-int-pairs-idx a a))
    
    ))

;(define int-pairs (pairs integers integers))
; pairs call itself forever. No cons-stream used in pairs.
