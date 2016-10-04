(require "../misc/paint/painters.ss")

(define aisaka
  (load-painter
   (build-path "../misc/resources/aisaka.jpg")))

;(define (right-split painter n)
;  (if (= n 0) painter
;      (let ((smaller (right-split painter (- n 1))))
;        (beside painter (below smaller smaller)))))

;(define (up-split painter n)
;  (if (= n 0) painter
;      (let ((smaller (up-split painter (- n 1))))
;        (below painter (beside smaller smaller)))))

(define (split 1st_op 2nd_op)
  (lambda (painter n)
    (if (= n 0) painter
        (let ((smaller ((split 1st_op 2nd_op) painter (- n 1))))
          (1st_op painter (2nd_op smaller smaller))))))

(define up-split (split below beside))
(define right-split (split beside below))

(paint (up-split aisaka 0))
(paint (up-split aisaka 1))
(paint (up-split aisaka 2))
(paint (up-split aisaka 3))

(paint (right-split aisaka 0))
(paint (right-split aisaka 1))
(paint (right-split aisaka 2))
(paint (right-split aisaka 3))