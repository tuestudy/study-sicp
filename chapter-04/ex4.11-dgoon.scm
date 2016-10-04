(load "ex4.09-dgoon.scm")

(define (make-frame-2 variables values)
  (map cons variables values))

(define (frame-variables-2 frame)
  (map car frame))

(define (frame-values-2 frame)
  (map cdr frame))

(define (add-binding-to-frame-2! var val frame)
  (let ((frame-clone (cons (car frame)
			   (cdr frame))))
    (set-car! frame (cons var val))
    (set-cdr! frame frame-clone)))
