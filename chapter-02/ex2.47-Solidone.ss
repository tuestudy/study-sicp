; answer
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (cadr frame))

(define (edge2-frame frame)
  (cadr (cdr frame)))

; code from book(p.175)

(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v)
                           (edge1-frame frame))
               (scale-vect (ycor-vect v)
                           (edge2-frame frame))))))

;test-case
(define origin "A")
(define edge1 "B")
(define edge2 "C")

(define FRAME (make-frame origin edge1 edge2))

(and (equal? origin
             (origin-frame FRAME))
     (equal? edge1
             (edge1-frame FRAME))
     (equal? edge2
             (edge2-frame FRAME))
     )
