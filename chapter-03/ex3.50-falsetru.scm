#lang planet neil/sicp

(define stream-car car)
(define (stream-cdr xs) (force (cdr xs)))
(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
    the-empty-stream
    (cons-stream
      (apply proc (map stream-car argstreams))
      (apply stream-map
             (cons proc (map stream-cdr argstreams))))))

(define result
  (stream-map
    +
    (cons-stream 1 (cons-stream 2 (cons-stream 3 the-empty-stream)))
    (cons-stream 2 (cons-stream 3 (cons-stream 4 the-empty-stream)))))

(equal? (stream-car result) 3)
(equal? (stream-car (stream-cdr result)) 5)
(equal? (stream-car (stream-cdr (stream-cdr result))) 7)
