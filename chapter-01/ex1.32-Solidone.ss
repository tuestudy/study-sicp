; define testing-code
(define (assert-equal? a b)
  (if (= a b)
      (display " <pass!> ")
      (display b)))

(define (assert-almost-equal? a b c)
  (if (>= c (abs (- a b)))
      (display " <pass!> ")
      (display b)))

; define section
(define (square x) (* x x))
(define (inc x) (+ x 1))
(define (identity x) x)

; define factorial
(define (factorial a b)
  (define (fact-term x)
    x)
  (product identity a inc b))

; define product
(define (product term a next b)
  (accumulate * 1 term a next b))

(define (product-iter term a next b)
  (accumulate-iter * 1 term a next b))

; solve
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner null-value term (next a) next b))))

(define (accumulate-iter combiner null-value term a next b)
  (define (iter x result)
    (if (> x b)
        result
        (iter (next x) (combiner (term x) result))))
  (iter a null-value))

; test-factorial
(assert-equal? 2 (factorial 1 2))
(assert-equal? 6 (factorial 1 3))
(assert-equal? 24 (factorial 1 4))
(assert-equal? 3628800 (factorial 1 10))