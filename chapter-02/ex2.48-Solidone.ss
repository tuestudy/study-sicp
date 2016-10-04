(load "ex2.46-Solidone.ss")

(define (make-segment vec1 vec2)
  (cons vec1 (cons vec2 '())))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cadr segment))

(define seg1 (make-segment (make-vect 1 2) (make-vect 9 8)))
(start-segment seg1)
(end-segment seg1)