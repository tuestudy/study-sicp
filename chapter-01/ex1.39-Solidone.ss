;define
(define (square x) (* x x))
(define (inc x) (+ x 1))
(define (dec x) (- x 1))

;solve
(define (cont-frac-iter n d k)
  (define (iter result counter)
    (if (= counter 0)
        result
        (iter (/ (n counter) (+ (d counter) result)) (dec counter))))
  (iter 0 k))

(define (tan-cf x k)
  (define (d i) (dec (* 2 i)))
  (define (n i)
    (if (= i 1)
        x
        (- (square x))))
  (cont-frac-iter n d k))

(tan 1.5)
(tan-cf 1.5 100)
(tan 2.0)
(tan-cf 2.0 100)