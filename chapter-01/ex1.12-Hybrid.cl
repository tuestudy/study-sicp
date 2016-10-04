(defun pascal (element depth)
   (cond ((> element depth) 0)
	      ((= element 1) 1)
	      ((= element depth) 1)
	      (T (+ (pascal (- element 1)
		            	    (- depth 1))
	              (pascal element
		                    (- depth 1))))))