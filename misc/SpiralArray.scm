(load "../misc/scheme-test.scm")

(define nil ())

(define (back-direction x y size)
  (let ((s-1 (- size 1))
	    (x+y (+ x y)))
	(cond ((and (= x 0) (= y 0)) (cons 0 0))
		  ((and (>= x y) (<= x+y s-1)) (cons -1 0))
		  ((and (>= x y) (> x+y s-1)) (cons 0 -1))
		  ((and (< x y) (>= x+y s-1)) (cons 1 0))
		  ((and (< x y) (< x+y s-1)) (cons 0 1))))) 

(define (number x y size)
  (let ((d (back-direction x y size)))
	(if (equal? d (cons 0 0))
		0
		(+ (number (+ x (car d)) (+ y (cdr d)) size) 1))))

(define (seq start end)
  (if (> start end)
	()
	(cons start (seq (+ start 1) end))))

(define (solve size)
  (let ((x (seq 0 (- size 1))))
	;(map (lambda (a) (map (lambda (b) (cons a b)) x)) x)))
	(map (lambda (a) (map (lambda (b) (number b a size)) x)) x)))

(define (print-it solution)
  (display "\n")
  (map (lambda (a) (display a) (display "\n") nil) solution))

(print-it (solve 6))

(run (make-testcase
  '(assert-equal? (cons 0 0) (back-direction 0 0 6))
  '(assert-equal? (cons -1 0) (back-direction 1 0 6))
  '(assert-equal? (cons -1 0) (back-direction 5 0 6))
  '(assert-equal? (cons 0 -1) (back-direction 5 1 6))
  '(assert-equal? (cons 0 -1) (back-direction 3 3 6))
  '(assert-equal? 0 (number 0 0 6))
  '(assert-equal? 1 (number 1 0 6))
  '(assert-equal? 2 (number 2 0 6))
  '(assert-equal? 5 (number 5 0 6))
  '(assert-equal? 6 (number 5 1 6))
  '(assert-equal? 10 (number 5 5 6))
  '(assert-equal? 11 (number 4 5 6))
  '(assert-equal? 15 (number 0 5 6))
  '(assert-equal? 16 (number 0 4 6))
  '(assert-equal? 17 (number 0 3 6))
  '(assert-equal? 19 (number 0 1 6))
  '(assert-equal? 20 (number 1 1 6))))

