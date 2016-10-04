(define (cont-frac-iter n d k)
  (define (iter i result)
    (if (= i 0) 
        result
        (iter (- i 1) (/ (n i) (+ (d i) result)))))
  (iter k 0))

(define (tan-cf x k) 
  (define (n i)
    (if (= i 1) x (- (* x x))))
  (cont-frac-iter n (lambda (k) (- (* k 2.0) 1)) k))

(tan 1)
(tan-cf 1 20)

(tan 3.14)
(tan-cf 3.14 20)
