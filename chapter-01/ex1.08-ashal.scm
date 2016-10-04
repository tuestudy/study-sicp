#lang scheme

(define (cube-root x)
  (cube-root-iter 1.0 x))

(define (cube-root-iter guess x)
  (if (good-enough? guess x)
      guess
      (cube-root-iter (improve guess x) x)))

(define (good-enough? guess x)
  (< (abs (- (cube guess) x))
     0.001))

(define (improve guess x)
  (/ (+ (/ x (square guess))
        (* 2 guess))
     3))

(define (square x) (* x x))

(define (cube x) (* x x x))

; tests -----------------
(and
 (< (abs (- 3 (cube-root 27))) 0.001)
 (< (abs (- 37 (cube-root 50653))) 0.001)
 (good-enough? 3.0 27.0)
 (not (good-enough? 4.0 27.0))
 (< (abs (- 5.38541666 (improve 8.0 10.0))) 0.001)
 (= 4 (square 2))
 (= 8 (cube 2))
)
