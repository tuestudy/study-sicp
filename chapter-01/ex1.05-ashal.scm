#lang scheme

; damn it!
(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

; story -------------------------

"(p) is suck."

"(test 0 2) is not 2."
(test 0 2)

"(test 1 2) is 2."
(test 1 2)

"(test 0 (p)) is not (p). but..."
(test 0 (p))
