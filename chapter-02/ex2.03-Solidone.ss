(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(define (average a b)
  (/ (+ a b) 2.0))

(define (make-point x y)
  (cons x y))

(define (x-point p) (car p))

(define (y-point p) (cdr p))

(define (midpoint-segment seg)
  (make-point (average (x-point (start-segment seg)) (x-point (end-segment seg)))
              (average (y-point (start-segment seg)) (y-point (end-segment seg)))))

(define (make-segment p1 p2)
  (cons p1 p2))

(define (start-segment seg)
  (car seg))

(define (end-segment seg)
  (cdr seg))

; solve
(define (make-rect p1 p2) (cons p1 p2))

(define (x-seg rect)
  (abs (- (x-point (car rect)) (x-point (cdr rect)))))

(define (y-seg rect)
  (abs (- (y-point (car rect)) (y-point (cdr rect)))))

(define (rect-peri rect)
  (* 2 (+ (x-seg rect) (y-seg rect))))

(define (rect-area rect)
  (* (x-seg rect) (y-seg rect)))

; value
(define a (make-point 4 100))
(print-point a)
(define b (make-point -17 54))
(print-point b)

(define seg1 (make-segment a b))
(print-point (start-segment seg1))
(print-point (end-segment seg1))
(print-point (midpoint-segment seg1))

(define rect1 (make-rect a b))
(rect-peri rect1)
(rect-area rect1)