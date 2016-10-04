(load "ch4-lazy-myeval-pkg-dgoon.scm")
(load "../misc/scheme-test-r5rs.scm")

;; problem b.

(define p1
  '
  (define (p1 x)
    (set! x (cons x '(2)))
    x))

(define p2
  '(define (p2 x)
     (define (p e)
       e
       x)
     (p (set! x (cons x '(2))))))

(define test-environment (setup-environment))
(myeval p1 test-environment)
(myeval p2 test-environment)

(run-named-test "b. Old eval-sequence"
		(make-testcase
		 '(assert-equal? '(1 2)
				 (actual-value '(p1 1) test-environment))
		 '(assert-equal? 1
				 (actual-value '(p2 1) test-environment))
		 ))

(define (eval-sequence exps env)
  (cond ((last-exp? exps) (myeval (first-exp exps) env))
	(else (actual-value (first-exp exps) env)
	      (eval-sequence (rest-exps exps) env))))

(run-named-test "b. Cy's eval-sequence"
		(make-testcase
		 '(assert-equal? '(1 2)
				 (actual-value '(p1 1) test-environment))
		 '(assert-equal? '(1 2)
				 (actual-value '(p2 1) test-environment))
		 ))
