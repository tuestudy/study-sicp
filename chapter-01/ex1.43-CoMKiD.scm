(define (inc x) (+ x 1))
(define (square x) (* x x))

(define (compose f g) (lambda (x) (f (g x))))
(define (repeated f n)
  (if (= n 1)
      f
      (compose f (repeated f (- n 1)))))

(define (repeated-iter f n)
  (define (iter result n)
    (if (= n 1) 
        result
        (iter (compose f result) (- n 1))))
  (iter f n))
        

