(define f1 (lambda (x) 1.0))
(define f2 (lambda (x) x))
(define (f3 x)
  (if (= (remainder x 3) 2)
      (* (+ (floor (/ x 3)) 1) 2)
      1))
(f3 0)
(f3 1)
(f3 2)
(f3 3)
(f3 4)
(f3 5)

(define (cont-frac n d k)
  (define (recursive k i)
    (if (= k 0)
        0
        (/ (n i) (+ (d i) (recursive (- k 1) (+ i 1))))))
  (recursive k 1))

(and
 (< (abs (- 1.0 (cont-frac f1 f2 1))) 0.0001)
 (< (abs (- (/ 2.0 3.0) (cont-frac f1 f2 2))) 0.0001)
 (< (abs (- (/ 1.0 3.0) (cont-frac f2 f1 2))) 0.0001)
 (< (abs (- (/ 7.0 10.0) (cont-frac f1 f2 3))) 0.0001)
 (< (abs (- (/ 2.0 3.0) (cont-frac f2 f1 3))) 0.0001)
 )

(+ 2 (cont-frac f1 f3 100))

;(/ 1.0 (cont-frac i i 100))

(define (cont-frac2 n d k)
  (define (iter n d k answer)
    (if (= k 0)
        answer
        (iter n d (- k 1) (/ (n k) (+ (d k) answer)))))
  (iter n d k 0))

(and
 (< (- 1.0 (cont-frac2 f1 f2 1)) 0.0001)
 (< (- (/ 2.0 3.0) (cont-frac2 f1 f2 2)) 0.0001)
 (< (- (/ 1.0 3.0) (cont-frac2 f2 f1 2)) 0.0001)
 (< (- (/ 7.0 10.0) (cont-frac2 f1 f2 3)) 0.0001)
 (< (- (/ 2.0 3.0) (cont-frac2 f2 f1 3)) 0.0001)
 )

;(/ 1.0 (cont-frac2 i i 100 1.0))