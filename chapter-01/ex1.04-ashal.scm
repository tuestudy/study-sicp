#lang scheme

(define (abs-sign-for x)
  (if (> x 0) + -))
(define (a-plus-abs-b a b)
  ((abs-sign-for b) a b))

; tests -----------------
(and
 (= (a-plus-abs-b 1 2) 3)
 (= (a-plus-abs-b 1 -2) 3)
)
