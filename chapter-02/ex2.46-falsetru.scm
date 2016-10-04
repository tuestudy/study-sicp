(define make-vector1 cons)
(define xcor-vect car)
(define ycor-vect cdr)
(define (add-vect v1 v2)
  (make-vector1
    (+ (xcor-vect v1) (xcor-vect v2))
    (+ (ycor-vect v1) (ycor-vect v2))))
(define (sub-vect v1 v2)
  (make-vector1
    (- (xcor-vect v1) (xcor-vect v2))
    (- (ycor-vect v1) (ycor-vect v2))))
(define (scale-vect s v)
  (make-vector1
    (* s (xcor-vect v))
    (* s (ycor-vect v))))
