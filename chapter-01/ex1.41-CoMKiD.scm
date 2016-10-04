(define (double f)
  (lambda (x) (f (f x))))

(define (inc x) (+ x 1))

(= ((double inc) 1) 3)
(= (((double (double double)) inc) 5) 21)
(= (((double (double double)) (lambda (x) (+ x 2))) 5) 37)