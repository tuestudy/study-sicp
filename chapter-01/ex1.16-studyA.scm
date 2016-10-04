(define (square x) (* x x))

(define (fast-expt b n)
  (fast-expt-iter b n 1))

(define (expt-iter b counter product)
  (if (= counter 0)
     product
     (expt-iter b
               (- counter 1)
               (* b product))))

(define (fast-expt-iter b n a)
  (cond ((= n 0) a)
       ((odd? n) (fast-expt-iter b (- n 1) (* a b)))
       (else (fast-expt-iter (square b) (/ n 2) a))))

(define (ex b n)
  (expt-iter b n 1))

(define (fast-ex b n)
  (fast-expt-iter b n 1))

(ex 2 1)
(ex 2 2)
(ex 2 3)
(ex 2 4)

(fast-ex 2 1)
(fast-ex 2 2)
(fast-ex 2 3)
(fast-ex 2 4)

(fast-ex 2 1000000)
(ex 2 1000000)

