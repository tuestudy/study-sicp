(load "ex2.38-falsetru.scm")

(define (reverse1 sequence)
  (fold-right2 (lambda (x y)
           (append y (list x)))
         null
         sequence))

(define (reverse2 sequence)
  (fold-left2 (lambda (x y) (cons y x))
         null
         sequence))
