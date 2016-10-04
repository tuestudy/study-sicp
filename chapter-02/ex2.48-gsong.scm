(load "../misc/scheme-test.scm")

(define (make-vect xcor ycor) (cons xcor ycor))
(define (xcor-vect vect) (car vect))
(define (ycor-vect vect) (cdr vect))
(define (add-vect v1 v2) (make-vect (+ (xcor-vect v1) (xcor-vect v2)) (+ (ycor-vect v1) (ycor-vect v2))))
(define (scale-vect v1 s) (make-vect (* s (xcor-vect v1)) (* s (ycor-vect v1))))
(define (sub-vect v1 v2) (add-vect v1 (scale-vect v2 -1)))

(run (make-testcase
      '(assert-equal? (xcor-vect (make-vect 1 1)) 1)
      '(assert-equal? (xcor-vect (make-vect 2 1)) 2)
      '(assert-equal? (ycor-vect (make-vect 1 1)) 1)
      '(assert-equal? (ycor-vect (make-vect 2 3)) 3)
      '(assert-equal? (xcor-vect (add-vect (make-vect 1 0) (make-vect 4 0))) 5)
      '(assert-equal? (ycor-vect (add-vect (make-vect 1 0) (make-vect 4 4))) 4)
      '(assert-equal? (xcor-vect (sub-vect (make-vect 1 0) (make-vect 4 0))) -3)
      '(assert-equal? (ycor-vect (sub-vect (make-vect 1 0) (make-vect 4 4))) -4)
      '(assert-equal? (xcor-vect (scale-vect (make-vect 1 0) 3)) 3)
      '(assert-equal? (ycor-vect (scale-vect (make-vect 1 4) 2)) 8)
      ))

(define (make-segment v1 v2)
  (list v1 v2))
(define (start-segment s)
  (car s))
(define (end-segment s)
  (cadr s))

(run (make-testcase
      '(assert-equal? (xcor-vect (start-segment (make-segment (make-vect 3 4) (make-vect 5 6)))) 3)
      '(assert-equal? (xcor-vect (end-segment (make-segment (make-vect 3 4) (make-vect 5 6)))) 5)
      ))