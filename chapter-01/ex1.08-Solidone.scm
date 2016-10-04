(define (square x) (* x x))
(define (cube x) (* x x x))
(define (average x y) (/ (+ x y) 2))

(define (square-root x)
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (sqrt-iter guess)
    (if (good-enough? guess)
        guess
        (sqrt-iter (improve guess))))
  (sqrt-iter 1.0))

(define (cube-root x)
  (define (good-enough2? guess)
    (< (abs (- (cube guess) x)) (* 0.00001 x)))
  (define (improve2 guess)
    (average guess (/ (+ (/ x (square guess)) (* 2 guess)) 3)))
  (define (cube-iter guess)
    (if (good-enough2? guess)
        guess
        (cube-iter (improve2 guess))))
  (cube-iter 1.0))

(sqrt 4)
