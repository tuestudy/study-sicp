(load "../chapter-03/ex3.53-dgoon.scm")

(display "---- ex3.54 ----\n")

;; code from the book
(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define (mul-streams x y) (stream-map * x y))
(define (add-streams x y) (stream-map + x y))

;; solution
(define factorials
  (cons-stream 1
	       (mul-streams factorials
			    integers)))

;; display
(display-stream (partial-stream factorials 10))
(newline)