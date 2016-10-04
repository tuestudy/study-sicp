(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v)
                           (edge1-frame frame))
               (scale-vect (ycor-vect v)
                           (edge2-frame frame))))))

;answer
(define (make-vect x y)
  (list x y))

(define (xcor-vect vector)
  (car vector))

(define (ycor-vect vector)
  (cadr vector))

(define (arith-vect func vector1 vector2)
  (let ((x (lambda (v) (xcor-vect v)))
        (y (lambda (v) (ycor-vect v))))
    (make-vect (func (x vector1) (x vector2))
               (func (y vector1) (y vector2)))))

(define (add-vect vector1 vector2)
  (arith-vect + vector1 vector2))

(define (sub-vect vector1 vector2)
  (arith-vect - vector1 vector2))

(define (scale-vect scale vector)
  (define vect (make-vect scale scale))
  (arith-vect * vect vector))

;test-case
(equal? (cons 1 (cons 2 null))
        (make-vect 1 2))

(define vector1 (make-vect 1 2))

(equal? 1 (xcor-vect vector1))
(equal? 2 (ycor-vect vector1))

(define vector2 (make-vect 10 2))

(equal? (make-vect 11 4)
        (add-vect vector1 vector2))

(equal? (make-vect -9 0)
        (sub-vect vector1 vector2))

(equal? (make-vect 9 18)
        (scale-vect 9 vector1))