;Common Lisp

;Recursive
(defun f-recursive (n)
   (if (< n 3) 3
       (+ (f-recursive (- n 1))
           (* 2 (f-recursive (- n 2)))
           (* 3 (f-recursive (- n 3))))))

;Iterative
(defun f-iter (a b c n)
   (if (= n 0) c
       (f-iter (+ a (* 2 b) (* 3 c))
                a
                b
                (- n 1))))
(defun f-iterative (n)
   (f-iter 3 3 3 n))