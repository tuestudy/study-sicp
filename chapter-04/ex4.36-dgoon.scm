;; inefficient, but it may find all pthagorean
(define (a-pythagorean-triple)
  (let ((i (an-integer-starting-from 1)))
    (let ((j (an-integer-between 1 i)))
      (let ((k (an-integer-between 1 i)))
	(require (= (+ (* k k) (* j j)) (* i i)))
	(list i j k)))))