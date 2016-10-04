; define testing-code
(define (assert-equal? a b)
  (if (= a b)
      (display " <pass!> \n")
      (display " <fail!> \n")))

(define (assert-similar? a b c)
  (if (>= c (abs (- a b)))
      (display " <pass!> \n")
      (display " <fail!> \n")))

; define example
(define (square x) (* x x))
(define (double x) (* 2 x))
(define (halve x) (/ x 2))

(define (product a b)
  (if (= b 0)
      0
      (+ a (product a (- b 1)))))

; define solve  

(define (fast-product a b)
  (cond ((= b 0) 0)
        ((even? b) (fast-product (double a) (halve b)))
        (else (+ a (fast-product a (- b 1))))))

; test-case
(assert-equal? 14 (fast-product 2 7))
(assert-equal? 1 (fast-product 1 1))
(assert-equal? 2 (fast-product 1 2))
(assert-equal? 3 (fast-product 1 3))
(assert-equal? 4 (fast-product 1 4))
(assert-equal? 2 (fast-product 2 1))
(assert-equal? 4 (fast-product 2 2))
(assert-equal? 6 (fast-product 2 3))
(assert-equal? 8 (fast-product 2 4))
(assert-equal? 72 (fast-product 9 8))
