#lang racket

(require "stream-base-falsetru.scm")

(define (pairs s t)
  (if (or (stream-null? s) (stream-null? t))
    the-empty-stream
    (cons-stream
      (list (stream-car s) (stream-car t))
      (interleave
        (stream-map (lambda (x) (list (stream-car s) x))
                    (stream-cdr t))
        (pairs (stream-cdr s) (stream-cdr t))))))

(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (interleave s2 (stream-cdr s1)))))

(define (triples a b c)
  (if (stream-null? a)
    the-empty-stream
    (let ((xs (stream-map (lambda (x) (cons (stream-car a) x)) (pairs b c))))
      (cons-stream
        (stream-car xs)
        (interleave 
          (stream-cdr xs)
          (triples (stream-cdr a) (stream-cdr b) (stream-cdr c)))
        ))))

(define pythagorean-triples
  (stream-filter
    (lambda (xs)
      (let ((i (car xs))
            (j (cadr xs))
            (k (caddr xs)))
        (= (+ (* i i) (* j j)) (* k k))))
    (triples integers integers integers)))


(require rackunit)
(require rackunit/text-ui)

(define ex3.69-tests
  (test-suite
   "Test for ex3.69"

   (test-case
    "triples"
    (check-equal? (stream->list (pairs (list->stream '(1 2))
                                       (list->stream '(a b))))
                  '((1 a)
                    (1 b)
                    (2 b)))
    (check-equal? (stream->list (triples (list->stream '(1 2))
                                         (list->stream '(a b))
                                         (list->stream '(x y))))
                  '((1 a x)
                    (1 a y)
                    (2 b y)
                    (1 b y)))

    (for-each (lambda (x) (printf "~a\n" x)) (stream-take pythagorean-triples 4))
    )
   ))

(exit (run-tests ex3.69-tests))
