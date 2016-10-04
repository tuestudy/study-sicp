#lang racket

(require "stream-base-falsetru.scm")
(provide
  weighted-pairs)

(define (weighted-pairs s t weight)
  (if (or (stream-null? s) (stream-null? t))
    the-empty-stream
    (cons-stream
      (list (stream-car s) (stream-car t))
      (merge-weighted
        (stream-map (lambda (x) (list (stream-car s) x))
                    (stream-cdr t))
        (weighted-pairs (stream-cdr s) (stream-cdr t) weight)
        weight))))

(define (merge-weighted s t weight)
  (cond [(stream-null? s) t]
        [(stream-null? t) s]
        [(<= (weight (stream-car s)) (weight (stream-car t)))
         (cons-stream (stream-car s)
                      (merge-weighted (stream-cdr s) t weight))]
        [else
         (cons-stream (stream-car t)
                      (merge-weighted s (stream-cdr t) weight))]
        ))

;; a.
;(printf "a.\n")
;(for-each (lambda (x) (printf "~a\n" x))
;          (stream-take
;            (weighted-pairs
;              integers integers
;              (lambda (x)
;                (let ((i (car x))
;                      (j (cadr x)))
;                  (+ i j))))
;            20))
;
;; b.
;(printf "b.\n")
;(for-each (lambda (x) (printf "~a\n" x))
;          (stream-take
;            (stream-filter
;              (lambda (x)
;                (let ((i (car x))
;                      (j (cadr x)))
;                  (and
;                    (> (remainder i 2) 0)
;                    (> (remainder j 2) 0)
;                    (> (remainder i 3) 0)
;                    (> (remainder j 3) 0)
;                    (> (remainder i 5) 0)
;                    (> (remainder j 5) 0))
;                  ))
;              (weighted-pairs
;                integers integers
;                (lambda (x)
;                  (let ((i (car x))
;                        (j (cadr x)))
;                    (+ (* 2 i) (* 3 j) (* 5 i j))))))
;            20))
