(require paint/painters)

; 1
(define (split join1 join2)
  (lambda (painter n)
    (if (= n 0)
        painter
        (let ((smaller ((split join1 join2) painter (- n 1))))
          (join1 painter (join2 smaller smaller))))))

; 2
(define (split join1 join2)
  (define (f painter n)
    (if (= n 0)
        painter
        (let ((smaller (f painter (- n 1))))
          (join1 painter (join2 smaller smaller)))))
  (lambda (painter n)
    (f painter n)))

(define right-split (split beside below))
(define up-split (split below beside))

; test
(paint-hires (right-split einstein 2))
(paint-hires (up-split einstein 2))