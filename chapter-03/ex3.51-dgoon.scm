(load "../chapter-03/ex3.50-dgoon.scm")
(display "\n----- ex 3.51 -----\n")

(define (display-line x)
  (newline)
  (display x))

(define (show x)
  (display-line x)
  x)

(define x
  (stream-map show
              (stream-enumerate-interval 0 10)))
(display-line "after (define x ...)")

(stream-ref x 5)
(display-line "after (stream-ref x 5)")

(stream-ref x 7)
(display-line "after (stream-ref x 7)")
(newline)
