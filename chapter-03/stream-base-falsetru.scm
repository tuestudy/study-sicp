#lang racket

; Copy of stream-base-dgoon.scm

(provide
  delay
  force
  the-empty-stream
  cons-stream
  stream-null?
  stream-car
  stream-cdr
  stream-ref
  stream-map
  stream-filter
  stream-take
  stream->list
  list->stream
  display-stream
  add-streams
  scale-stream
  partial-sums
  partial-stream
  integers-starting-from
  integers
  )

(define-syntax cons-stream
  (syntax-rules ()
    ((cons-stream x y)
     (cons x (delay y)))))

(define force (lambda (x) (x)))

(define (memo-proc proc)
  (let ((already-run? false) (result false))
    (lambda ()
      (if (not already-run?)
          (begin (set! result (proc))
                 (set! already-run? true)
                 result)
          result))))

; memoized delay
(define-syntax delay
  (syntax-rules ()
    ((delay x)
     (memo-proc (lambda () x)))))

;(define-syntax delay
;  (syntax-rules ()
;    ((delay x)
;     (lambda () x))))


(define (stream-car stream) (car stream))
(define (stream-cdr stream) (force (cdr stream)))
(define the-empty-stream '())
(define stream-null? null?)
(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))

; code of stream-map in the book
(define (stream-map proc . arguments)
  (if (stream-null? (car arguments))
      the-empty-stream
      (cons-stream
        (apply proc (map stream-car arguments))
        (apply stream-map
               (cons proc (map stream-cdr arguments))))))

(define (stream-filter pred stream)
  (cond ((stream-null? stream) the-empty-stream)
        ((pred (stream-car stream))
         (cons-stream (stream-car stream)
                      (stream-filter pred
                                     (stream-cdr stream))))
        (else (stream-filter pred (stream-cdr stream)))))

; code of stream-for-each in the book
(define (stream-for-each proc s)
  (if (stream-null? s)
      'done
      (begin (proc (stream-car s))
             (stream-for-each proc (stream-cdr s)))))

(define (display-stream s)
  (stream-for-each display-line s))

(define (display-line x)
  (newline)
  (display x))

; written by dgoon
(define (partial-stream s n)
  (define (iter cur-stream cur)
    (if (> cur n)
	the-empty-stream
	(cons-stream (stream-car cur-stream)
		     (iter (stream-cdr cur-stream)
			   (+ cur 1)))))
  (iter s 0))

(define (stream-take s n)
  (define (iter cur-stream cur)
    (if (> cur n)
	'()
	(cons (stream-car cur-stream)
              (iter (stream-cdr cur-stream)
                    (+ cur 1)))))
  (iter s 1))

(define (stream->list s)
  (if (stream-null? s)
    empty
    (cons (stream-car s) (stream->list (stream-cdr s)))))

(define (list->stream xs)
  (if (empty? xs)
    the-empty-stream
    (cons-stream (car xs) (list->stream (cdr xs)))))

(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define (scale-stream s mul)
  (stream-map (lambda (x) (* x mul)) s))

(define (partial-sums s)
  (define result
    (cons-stream
      (stream-car s)
      (add-streams result (stream-cdr s))))
  result)

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))
