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
(define (fast-product2 a b)
  (define (iter a b answer)
  (cond ((= b 0) answer)
        ((even? b) (iter (double a) (halve b) answer))
        (else (iter a (- b 1) (+ answer a)))))
  (iter a b 0))

; test-case
(assert-equal? 1 (fast-product2 1 1))
(assert-equal? 2 (fast-product2 1 2))
(assert-equal? 3 (fast-product2 1 3))
(assert-equal? 4 (fast-product2 1 4))
(assert-equal? 2 (fast-product2 2 1))
(assert-equal? 4 (fast-product2 2 2))
(assert-equal? 6 (fast-product2 2 3))
(assert-equal? 8 (fast-product2 2 4))
(assert-equal? 72 (fast-product2 9 8))
