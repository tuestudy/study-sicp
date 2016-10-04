(define (square x) (* x x))

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(define (faster-expt b n)
  (define (iter b n a)
    (cond ((= n 0) a)
          ((even? n) (iter (square b) (/ n 2) a))
          (else (iter b (- n 1) (* a b)))))
  (iter b n 1))


(equal? (fast-expt 3 1) (faster-expt 3 1))
(equal? (fast-expt 3 2) (faster-expt 3 2))
(equal? (fast-expt 3 3) (faster-expt 3 3))
(equal? (fast-expt 3 4) (faster-expt 3 4))
          
