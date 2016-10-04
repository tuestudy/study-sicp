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

; define solve  
(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (square p) (square q))
                   (+ (* 2 p q) (square q))
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))

                   
; test-case
(assert-equal? 0 (fib 0))
(assert-equal? 1 (fib 1))
(assert-equal? 1 (fib 2))
(assert-equal? 2 (fib 3))
(assert-equal? 3 (fib 4))
(assert-equal? 5 (fib 5))
(assert-equal? 8 (fib 6))
(assert-equal? 13 (fib 7))
(assert-equal? 21 (fib 8))