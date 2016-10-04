;Common Lisp

;Iterative function for Ex 1.16
(defun fast-expt-iter (product b n)
   (cond ((= n 0) product)
	 	 ((= b 1 ) product)
		 ((evenp n) (fast-expt-iter product (square b) (/ n 2)))
		 (T (fast-expt-iter (* product b)
						   (square b)
						   (/ (- n 1) 2)))))
(defun fast-expt (b n)
   (fast-expt-iter 1 b n))

;Iterative function for Ex 1.17
(defun double (a)
	(+ a a))
(defun halve (a)
	(/ a 2))

(defun *-iter (product a b)
   (if (= b 0)
       product
       (if (evenp b)
	   (*-iter product
		   (double a)
		   (halve b))
	   (*-iter (+ product a)
		  a
		  (- b 1)))))
(defun * (a b)
   (*-iter 0 a b))
