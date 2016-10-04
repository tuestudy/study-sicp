(require "../misc/paint/painters.ss")

(define aisaka
  (load-painter
   (build-path "../misc/resources/aisaka.jpg")))

(define (up-split painter n)
  (if (= n 0) painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))

(paint (up-split aisaka 0))
(paint (up-split aisaka 1))
(paint (up-split aisaka 2))
(paint (up-split aisaka 3))