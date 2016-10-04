(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

; solve
(define (average a b)
  (/ (+ a b) 2.0))

(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

(define (midpoint-segment seg)
  (make-point (average (x-point (start-segment seg)) (x-point (end-segment seg)))
              (average (y-point (start-segment seg)) (y-point (end-segment seg)))))

(define (make-segment p1 p2)
  (cons p1 p2))

(define (start-segment seg)
  (car seg))

(define (end-segment seg)
  (cdr seg))

; value
(define a (make-point 4 100))
(print-point a)
(define b (make-point -17 54))
(print-point b)

(define seg1 (make-segment a b))
(print-point (start-segment seg1))
(print-point (end-segment seg1))
(print-point (midpoint-segment seg1))