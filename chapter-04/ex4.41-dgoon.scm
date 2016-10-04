;;; ex4.41

(define (range s e)
  (if (> s e)
      '()
      (cons s (range (+ s 1) e))))
(display (range 1 10))(newline)

(define (permutation l depth)
  (if (= 1 depth)
      '()
      (map (lambda (x)
	     (cons x (permutation l (- depth 1))))
	   l)))

(display (permutation (range 1 3) 3))(newline)
