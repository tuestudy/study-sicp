#lang racket

(require "stream-base-falsetru.scm")

(define (sign-change-detector current-value last-value)
  (cond [(and (< last-value 0) (>= current-value 0)) +1]
        [(and (>= last-value 0) (< current-value 0)) -1]
        [else 0]))


(define (smooth s)
  (define (smooth-aux s x-2 x-1)
    (if (stream-null? s) the-empty-stream
      (let ((x-0 (stream-car s)))
        (cons-stream (/ (+ x-2 x-1 (stream-car s)) 3)
                     (smooth-aux (stream-cdr s) x-1 x-0))
        )))
  (smooth-aux (stream-cdr (stream-cdr s)) (stream-car s) (stream-car (stream-cdr s))))


(define (make-zero-crossings input-stream last-value)
  (cons-stream
   (sign-change-detector (stream-car input-stream) last-value)
   (make-zero-crossings (stream-cdr input-stream)
                        (stream-car input-stream))))

;(define zero-crossings (make-zero-crossings (smooth sense-data) 0))

(require rackunit)
(require rackunit/text-ui)

(define ex3.76-tests
  (test-suite
   "Test for ex3.76"

   (check-equal? (stream->list (smooth (list->stream '(1 2 3 1 2 0))))
                 '(2 2 2 1))
   ))

(exit (run-tests ex3.76-tests))
