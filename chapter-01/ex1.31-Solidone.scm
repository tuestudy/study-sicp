; define testing-code
(define (assert-equal? a b)
  (if (= a b)
      (display " <pass!> ")
      (display b)))

(define (assert-similar? a b c)
  (if (>= c (abs (- a b)))
      (display " <pass!> ")
      (display b)))

; define section
(define (square x) (* x x))
(define (inc x) (+ x 1))
(define (identity x) x)

(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

(define (product-iter term a next b)
  (define (iter x result)
    (if (> x b)
        result
        (iter (next x) (* (term x) result))))
  (iter a 1))

; define factorial
(define (factorial a b)
  (define (fact-term x)
    x)
  (product identity a inc b))

; test factorial
(assert-equal? 2 (factorial 1 2))
(assert-equal? 6 (factorial 1 3))
(assert-equal? 24 (factorial 1 4))
(assert-equal? 3628800 (factorial 1 10))


; define solve
(define (pi-sum a b)
  (define (pi-term x)
    (/ (* (+ x 1) (+ x 1)) (* x (+ x 2))))
  (define (pi-next x)
    (+ x 2))
  (* 2 (product pi-term a pi-next b)))

(define (pi-sum-iter a b)
  (define (pi-term x)
    (/ (square (+ x 1)) (* x (+ x 2))))
  (define (pi-next x)
    (+ x 2))
  (* 2 (product-iter pi-term a pi-next b)))

; test-case
(assert-similar? 3.14159625 (pi-sum 1 1000) 0.01)
(assert-similar? 3.14159625 (pi-sum-iter 1 1000) 0.01)