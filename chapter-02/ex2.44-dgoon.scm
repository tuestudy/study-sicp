;; (require (planet "sicp.ss" ("soegaard" "sicp.plt" 1 1))) ; install
(require "../misc/paint/painters.ss")

(define aisaka
  (load-painter
   (build-path "../misc/resources/aisaka.jpg")))

;; test
;(paint (flip-vert aisaka))
;(paint aisaka)
;(paint (flip-horiz aisaka))

;(paint (below aisaka aisaka))
;(paint (beside aisaka aisaka))

(define (upsplit painter n)
  (if (= n 0)
      painter
      (let ((smaller (upsplit painter (- n 1))))
        (below painter (beside smaller smaller)))))

(paint (upsplit aisaka 1))
(paint (upsplit aisaka 2))
(paint (upsplit aisaka 3))

