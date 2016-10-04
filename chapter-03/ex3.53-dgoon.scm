(load "../chapter-03/stream-base-dgoon.scm")
(load "../chapter-03/ex3.50-dgoon.scm")
(load "../chapter-03/ex3.51-dgoon.scm")

(display "---- ex3.53 ----\n")

;; add-stream in the book
(define (add-streams s1 s2)
  (stream-map + s1 s2))

;; stream 's' in the book
(define s (cons-stream 1 (add-streams s s)))

;; copied from the bookd
(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor))
	      stream))

;; stream 'double' in the book
(define double (cons-stream 1 (scale-stream double 2)))

(display "First 10 elements of stream 's'")
(display-stream (partial-stream s 10))
(newline)

(display "First 10 elements of stream 'double'")
(display-stream (partial-stream double 10))
(newline)