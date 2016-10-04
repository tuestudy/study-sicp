(define (dec x) (- x 1))
(define (average x y) (/ (+ x y) 2))
(define (square x) (* x x))
(define (cube x) (* x x x))
(define (average-damp f)
  (lambda (x) (average x (f x))))

(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (define (iter result counter)
    (if (= counter 1)
        result
        (iter (compose f result) (dec counter))))
  (iter f n))

(define (power x i)
  (define f (lambda (x y) (* x y)))
  (define (iter result counter)
    (if (= counter 1)
        result
        (iter (f result x) (dec counter))))
  (iter x i))

(define (4th-root x)
  (fixed-point ((repeated average-damp 2) (lambda (y) (/ x (power y 3))))
               1.0))

(define (nth-root x n)
  (fixed-point ((repeated average-damp n) (lambda (y) (/ x (power y (dec n)))))
  1.0))

(power (4th-root 1000) 4)
(power (nth-root 1000 4) 4)
(power (nth-root 487596 7) 7)
