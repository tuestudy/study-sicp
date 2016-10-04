(define (series x)
  (define (s-iter a b c cur x)
    (if (= cur x)
        c
	(s-iter b
		c
                (+ c (* b 2) (* a 3))
		(+ cur 1)
		x)))
  (if (< x 3)
      x
      (s-iter  1 2 4 3 x)))