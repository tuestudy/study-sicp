#lang racket

(require "stream-base-falsetru.scm")

(define sense-data
  (list->stream
    '(1 2 1.5 1 0.5 -0.1 -2 -3 -2 -0.5 0.2 3 4)))

(define (sign-change-detector current-value last-value)
  (cond [(and (< last-value 0) (>= current-value 0)) +1]
        [(and (>= last-value 0) (< current-value 0)) -1]
        [else 0]))


(define (make-zero-crossings input-stream last-value last-avpt)
  (if (stream-null? input-stream) the-empty-stream
    (let ((avpt (/ (+ (stream-car input-stream) last-value) 2)))
      (cons-stream (sign-change-detector avpt last-avpt)
                   (make-zero-crossings (stream-cdr input-stream)
                                        (stream-car input-stream)
                                        avpt)))))

(define zero-crossings (make-zero-crossings sense-data 0 0))

(require rackunit)
(require rackunit/text-ui)

(define ex3.75-tests
  (test-suite
   "Test for ex3.75"
   (check-equal? (stream->list zero-crossings)
                 '(0 0 0 0 0 0 -1 0 0 0 0 +1 0))
   ))

(exit (run-tests ex3.75-tests))
