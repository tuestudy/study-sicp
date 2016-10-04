(load "ex2.50-falsetru.scm")

(define (below painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((paint-down
           (transform-painter painter1
                              (make-vect 0 0)
                              (make-vect 1 0)
                              split-point))
          (paint-up
           (transform-painter painter2
                              split-point
                              (make-vect 1 0.5)
                              (make-vect 0 1))))
      (lambda (frame)
        (paint-up frame)
        (paint-down frame)))))

(define (below painter1 painter2)
  (rotate90 (beside
             (rotate270 painter1)
             (rotate270 painter2))))

; (paint (below einstein diagonal-shading))