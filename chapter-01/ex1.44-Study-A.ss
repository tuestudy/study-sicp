
(define (square a) (* a a))
(define (inc a) (+ a 1))

(define (compose a b)
  (lambda (x) (a (b x))))

(define (repeated-recursive f n)
  (if (= n 1)
      f
      (compose f (repeated-recursive f (- n 1)))))

(define (repeated f n)
  (define (iter n composed-f)
    (if (= n 1)
        composed-f
        (iter (- n 1) (compose f composed-f))))
  (iter n f))

(define (smooth dx)
  (lambda (f x) (/ (+ (f (- x dx)) (f x) (f (+ x dx))) 3)))

(define (n-smooth dx)
  (define (smoothed-f dx f)
    (lambda (x) ((smooth dx) f x)))
  (lambda (f n x)
    ((repeated (smoothed-f dx f) n) x)))

(define (f1 x) x)
(define (f2 x) (+ (* x 2) 0.5))

(and
 (equal? 49 ((compose square inc) 6))
 (equal? 625 ((repeated square 2) 5))
 (equal? (square 625) ((repeated square 3) 5))
 (equal? 1 ((smooth 1) f1 1))
 (equal? 1 ((n-smooth 1) f1 10 1))
 (equal? 2.5 ((smooth 1) f2 1))
 (equal? ((smooth 1) f2 2.5) ((n-smooth 1) f2 2 1))
 )