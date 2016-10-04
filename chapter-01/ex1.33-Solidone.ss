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

; define prime?
(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

; solve
(define (filtered-accumulate filter combiner null-value term a next b)
  (define (predicate x)
    (if (filter x)
        x
        null-value))
  (define (iter x result)
    (if (> x b)
        result
        (iter (next x) (combiner (term (predicate x)) result))))
  (iter a null-value))

(define (sum-prime a b)
  (filtered-accumulate prime? + 0 identity a inc b))

(define (product-rel-prime b)
  (define (relatively-prime? x) (= (gcd x b) 1))
  (filtered-accumulate relatively-prime? * 1 identity 0 inc b))

; test-case
(assert-equal? (+ 1 2 3 5 7) (sum-prime 1 10))
(assert-equal? (+ 2 3 5 7 11 13 17 19) (sum-prime 2 20))
(assert-equal? (* 1 2 3 4) (product-rel-prime 5))
(assert-equal? (* 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18) (product-rel-prime 19))
(assert-equal? (* 1 3 5 7 9 11 13 15) (product-rel-prime 16))