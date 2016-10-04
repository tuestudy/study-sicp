;define
(define (square x) (* x x))
(define (inc x) (+ x 1))
(define tolerance 0.0001)
(define phi (/ (+ 1 (sqrt 5)) 2.0))
(define target (/ 1 phi))

(define (close-enough? v1 v2)
  (< (abs (- v1 v2)) tolerance))

(define (cont-frac-iter n d k)
  (define (f x) (/ (n k) (+ (d k) x)))
  (define (iter result counter)
    (if (> counter k)
        result
        (iter (f result) (inc counter))))
  (iter 0 1))

(define (cont-frac n d k)
  (define (f x) (/ (n k) (+ (d k) x)))
  (if (= k 0)
      0
      (+ (f (cont-frac n d (- k 1)))))) 

;solve
(cont-frac-iter (lambda (i) 1.0)
                (lambda (i) 1.0)
                1)
(close-enough? target (cont-frac-iter (lambda (i) 1.0)
                                      (lambda (i) 1.0)
                                      10))
(cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           1)