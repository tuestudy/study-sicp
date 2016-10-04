; 2.44

(require "../misc/paint/painters.ss")

(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))


; test
(paint (up-split charm 5))