(load "ex4.16-dgoon.scm")

(define pure-fact-10
  '((lambda (n)
      ((lambda (fact)
	 (fact fact n))
       (lambda (ft k)
	 (if (= k 1)
	     1
	     (* k (ft ft (- k 1)))))))
    10))

(define (fact n)
  (or (and (= n 1) 1)
      (* n (fact (- n 1)))))

(define pure-fibo-10
  '((lambda (n)
      ((lambda (fibo)
	 (fibo fibo n))
       (lambda (fb n)
	 (if (< n 3)
	     1
	     (+ (fb fb (- n 2))
		(fb fb (- n 1)))))))
    10))

(define (fibo n)
  (if (< n 3)
      1
      (+ (fibo (- n 2))
	 (fibo (- n 1)))))

