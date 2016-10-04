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

(define (expt1 b n)
  (if (= n 0)
      1
      (* b (expt1 b (- n 1)))))

(define (expt2 b n)
  (expt-iter b n 1))

(define (expt-iter b counter product)
  (if (= counter 0)
      product
      (expt-iter b
                 (- counter 1)
                 (* b product))))

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

; define solve  
(define (fast-expt2 b n)
  (define (iter b counter product)
    (cond ((= counter 0) product)
          ((even? counter)
           (iter (square b) (/ counter 2) product))
          (else
           (iter b (- counter 1) (* b product)))))
  (iter b n 1))

; test-case
(define a 2)
(define b 7)

(assert-equal? (expt2 b 8) (fast-expt b 8))

(assert-equal? (fast-expt a 49) (fast-expt2 a 49))
(assert-equal? (fast-expt b 49) (fast-expt2 b 49))
(assert-equal? (fast-expt b 100) (fast-expt2 b 100))

(assert-equal? (faster-expt b 49) (fast-expt2 b 49))
