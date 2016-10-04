(define (dec x) (- x 1))

; smooth
(define dx 0.00001)

(define (average x y z) (/ (+ x y z) 3))

(define (smooth f)
  (lambda (x) (average (f (- x dx)) (f x) (f (+ x dx)))))

(define (square x) (* x x))

; a second order function
(define (sec-order-func x)
  (+ (square x) (* 2 x) 1))

; solve
(define (repeated-smooth f n)
  (if (= n 0)
      f
      (smooth (repeated-smooth f (dec n)))))

(define (repeated-smooth-iter f n)
  (define (iter result counter)
    (if (= counter 0)
      result
      (iter (smooth result) (dec counter))))
  (iter f n))

; value
((smooth sec-order-func) 1)
((repeated-smooth sec-order-func 1) 1)
((repeated-smooth sec-order-func 2) 1)
((repeated-smooth sec-order-func 3) 1)
((repeated-smooth sec-order-func 4) 1)
((repeated-smooth-iter sec-order-func 1) 1)
((repeated-smooth-iter sec-order-func 2) 1)
((repeated-smooth-iter sec-order-func 3) 1)
((repeated-smooth-iter sec-order-func 4) 1)