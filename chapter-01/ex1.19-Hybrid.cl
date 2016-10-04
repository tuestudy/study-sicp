;Common Lisp

(defun square (a) (* a a))

;Just the answer
;p' = p^2 + q^2
(+ (square p) (square q))
;q' = q^2 + 2pq
(+ (square q) (* 2 p q))

;Full code of Fibonacci iterative function in logarithmic steps
(defun fib-iter (a b p q count)
   (cond ((= count 0) b)
	 ((evenp count)
	  (fib-iter a
		    b
		    (+ (square p)
		       (square q))
		    (+ (square q) (* 2 p q))
		    (/ count 2)))
	 (T (fib-iter (+ (* b q) (* a q) (* a p))
		      (+ (* b p) (* a q))
		      p
		      q
		      (- count 1)))))
