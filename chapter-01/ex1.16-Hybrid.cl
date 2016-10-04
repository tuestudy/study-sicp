;Common Lisp

(defun square (a)
	(* a a))
(defun fast-expt (b n)
   (cond ((= n 0) 1)
	 ((evenp n) (fast-expt (square b)
			       		     (/ n 2)))
	 (T (* b (fast-expt (square b)
				    	     (/ (- n 1) 2))))))