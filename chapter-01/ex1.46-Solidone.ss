; define testing-code
(define (assert-equal? a b)
  (if (= a b)
      (display " <pass!> ")
      (display b)))

(define (assert-almost-equal? a b c)
  (if (>= c (abs (- a b)))
      (display " <pass!> ")
      (display b)))

; define basic
(define (square x) (* x x))
(define (average x y)
  (/ (+ x y) 2))
(define tolerance 0.00001)

; 1.1.7 sqrt
(define (sqrt1 x)
  (define (improve guess)
    (average guess (/ x guess)))
  (iterative-improve improve 0.1))

; 1.3.3 fixed-point
(define (fixed-point f first-guess)
  (iterative-improve f 0.1))

; solve
(define (iterative-improve f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (iter guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (iter next))))
  (iter first-guess))

;test-case
(assert-almost-equal? 3 (sqrt1 9) tolerance)
(assert-almost-equal? (sqrt 137) (sqrt1 (+ 100 37)) tolerance)
(assert-almost-equal? (sqrt (+ (sqrt 2) (sqrt 3))) (sqrt1 (+ (sqrt1 2) (sqrt1 3))) tolerance)
(assert-almost-equal? 1000 (square (sqrt1 1000)) tolerance)

(assert-almost-equal? (cos (fixed-point cos 1.0)) (fixed-point cos 1.0) tolerance)
(define a (lambda (y) (+ (sin y) (cos y))))
(assert-almost-equal? (a (fixed-point a 1.0)) (fixed-point a 1.0) tolerance)

