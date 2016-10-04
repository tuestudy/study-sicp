(load "ex4.21-dgoon.scm")
(load "../misc/scheme-test-r5rs.scm")

;; a. Yes, it works...

(run-named-test "Test for a - Recursion without define/let"
		(make-testcase
		 '(assert-equal? (fact 10)
				 (myeval pure-fact-10
					 (setup-environment)))
		 '(assert-equal? (fibo 10)
				 (myeval pure-fibo-10
					 (setup-environment)))
		 ))



;; b. just fill the blanks...
;; This procedure determins if the args is even or odd.
;; return TRUE if even
;;        FALSE otherwise

(define (f x)
  ((lambda (even? odd?)
     (even? even? odd? x))
   (lambda (ev? od? n)
     (if (= n 0) true
	 (od? ev? od? (- n 1))))
   (lambda (ev? od? n)
     (if (= n 0) false
	 (ev? ev? od? (- n 1))))))

(run-named-test "Test for b - Recursion without define/let"
		(make-testcase
		 '(assert-equal? '(#t #f #t #f #t #f)
				 (map f '(0 1 2 3 4 5)))))