;Common Lisp

(defun double (a)
	(+ a a))
(defun halve (a)
	(/ a 2))

(defun * (a b)
   (if (= b 0)
       0
       (if (evenp b)
		(* (double a) (halv b))
		(+ a (* a (- b 1))))))