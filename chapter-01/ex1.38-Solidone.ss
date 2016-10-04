; define testing-code
(define (assert-equal? a b)
  (if (= a b)
      (display " <pass!> ")
      b))

(define (assert-almost-equal? a b c)
  (if (>= c (abs (- a b)))
      (display " <pass!> ")
      (display b)))

;define
(define (square x) (* x x))
(define (inc x) (+ x 1))
(define tolerance 0.00001)
(define target 0.71828182845904509) ; e - 2

(define (close-enough? v1 v2)
  (< (abs (- v1 v2)) tolerance))

(define (euler-cont-frac n d k)
  (define (f x i) (/ (n k) (+ (d i) x)))
  (define (iter result counter)
    (if (> counter k)
        result
        (iter (f result (inc (- k counter))) (inc counter))))
  (iter 0 1))


(define (d i)
  (cond ((= (remainder i 3) 2) (* (ceiling (/ i 3)) 2))
        (else 1)))

;solve

(assert-equal? 1 (d 1))
(assert-equal? 2 (d 2))
(assert-equal? 1 (d 3))
(assert-equal? 1 (d 4))
(assert-equal? 4 (d 5))
(assert-equal? 1 (d 6))
(assert-equal? 1 (d 7))
(assert-equal? 6 (d 8))
(assert-equal? 1 (d 9))
(assert-equal? 1 (d 10))
(assert-equal? 8 (d 11))
(assert-equal? (/ 1 1) (euler-cont-frac (lambda (i) 1.0) d 1))
(assert-equal? (/ 2.0 3) (euler-cont-frac (lambda (i) 1.0) d 2))
(assert-equal? (/ 3 4) (euler-cont-frac (lambda (i) 1.0) d 3))
(assert-equal? (/ 5.0 7) (euler-cont-frac (lambda (i) 1.0) d 4))
(close-enough? target (euler-cont-frac (lambda (i) 1.0) d 100))
