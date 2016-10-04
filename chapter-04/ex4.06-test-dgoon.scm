(load "ex4.06-dgoon.scm")
(load "../misc/scheme-test-r5rs.scm")

(display "----- TEST EX4.06 -----\n")
(define test-environment (setup-environment))
(define test-let '(let ((a 1)
			(b 2))
		    (+ 0 a)
		    (+ a b)))
(define test-lambda '((lambda (a b) (+ 0 a) (+ a b)) 1 2))

(display "test for selectors:")(newline)
(run (make-testcase
      '(assert-equal? '((a 1) (b 2))
		      (let-exps test-let))
      '(assert-equal? '((+ 0 a) (+ a b))
		      (let-body test-let))
      '(assert-equal? '(a b)
		      (let-vars (let-exps test-let)))
      '(assert-equal? '(1 2)
		      (let-vals (let-exps test-let)))
      ))
;
;(display "test for assembler:")(newline)
;(run (make-testcase
;      '(assert-equal? '((lambda (a b) (+ a b)) 1 2)
;		      (make-lambda '(a b)
;				   '(+ a b)
;				   '(1 2)))))

(display "test for let-combination:")(newline)
(run (make-testcase
      '(assert-equal? test-lambda
		      (let-combination test-let))
      ))

(display "test for myeval-let-combination")(newline)
(run (make-testcase
      '(assert-equal? 3
		      (myeval test-let test-environment))
      ))