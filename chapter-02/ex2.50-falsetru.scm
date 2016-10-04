;(require paint/painters)
(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))
(load "ex2.46-falsetru.scm")

(define (transform-painter painter origin corner1 corner2)
  (lambda (frame)
    (let ((m (frame-coord-map frame)))
      (let ((new-origin (m origin)))
        (painter
         (make-frame new-origin
                     (sub-vect (m corner1) new-origin)
                     (sub-vect (m corner2) new-origin)))))))

(define (flip-horiz painter)
  (transform-painter painter
                     (make-vect 1 0)
                     (make-vect 0 0)
                     (make-vect 1 1)))

(define (roate180 painter)
  (transform-painter painter
                    (make-vect 1 1)
                    (make-vect 0 1)
                    (make-vect 1 0)))

(define (rotate270 painter)
  (transform-painter painter
                     (make-vect 0 1)
                     (make-vect 0 0)
                     (make-vect 1 1)))

; (paint (rotate270 einstein))
