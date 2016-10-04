#lang racket/base

(require "stream-base-falsetru.scm")

(define (stream-enumerate-interval low high)
  (if (> low high)
    the-empty-stream
    (cons-stream
      low
      (stream-enumerate-interval (+ low 1) high))))

(define (stream-filter pred stream)
  (cond ((stream-null? stream) the-empty-stream)
        ((pred (stream-car stream))
         (cons-stream (stream-car stream)
                      (stream-filter pred
                                     (stream-cdr stream))))
        (else (stream-filter pred (stream-cdr stream)))))


(define sum 0)
(define (accum x)
  (set! sum (+ x sum))
  sum)
(define seq (stream-map accum (stream-enumerate-interval 1 20)))
(define y (stream-filter even? seq))
(define z (stream-filter (lambda (x) (= (remainder x 5) 0))
                         seq))


(stream-ref y 7)
(display-stream z)

; memoized delay
;
; 136
; 
; 10
; 15
; 45
; 55
; 105
; 120
; 190
; 210'done
;
; sum -> 210

; non-memoized delay
;
; 162
; 
; 15
; 180
; 230
; 305'done
; sum -> 362
