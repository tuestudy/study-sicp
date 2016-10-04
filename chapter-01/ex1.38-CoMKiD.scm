(define (cont-frac-iter n d k)
  (define (iter i result)
    (if (= i 0) 
        result
        (iter (- i 1) (/ (n i) (+ (d i) result)))))
  (iter k 0))

(define (d i)
  (cond ((= i 2) 2.0)
        ((= (remainder (- i 2) 3) 0) 
         (+ 2.0 (* (quotient (- i 2) 3) 2)))
        (else 1.0)))

(define (base-of-natural-log? k)
  (> 0.00001
     (abs (- 2.718281828459
             (+ 2
                (cont-frac-iter (lambda (i) 1.0) d k))))))

(define (find-k pred)
  (define (find i)
    (if (pred i) i (find (+ i 1))))
  (find 1))

(find-k base-of-natural-log?)