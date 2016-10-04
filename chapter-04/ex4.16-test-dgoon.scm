(load "ex4.16-dgoon.scm")
(load "../misc/scheme-test-r5rs.scm")

(define test-environment (setup-environment))

(define test-unassigned
  '(let ((a '*unassigned*))
     a))

(run-named-test "TEST for a"
		(make-testcase
		 ;'(assert-error? (myeval test-unassigned test-environment)) ; Should report an ERROR!
		 ))

(define inner-define-proc
  '(lambda (a b)
     (define sum (lambda (x y) (+ x y)))
     (define identity (lambda (x) x))
     (sum (identity a) (identity b))))

(define scanned-out-proc
  '(lambda (a b)
     (let ((sum '*unassigned*)
	   (identity '*unassigned*))
       (set! sum (lambda (x y) (+ x y)))
       (set! identity (lambda (x) x))
       (sum (identity a) (identity b)))))

(run-named-test "TEST for b - helpers"
		(make-testcase
		 '(assert-equal? '(1 2 3 4 5)
				 (filter (lambda (x) (< x 6))
					 '(1 2 3 4 5 6 7 8 9 10)))
		 '(assert-equal? '((define sum (lambda (x y) (+ x y)))
				   (define identity (lambda (x) x)))
				 (collect-definitions inner-define-proc))
		 '(assert-equal? '(sum identity)
				 (definition-vars
				   (collect-definitions inner-define-proc)))
		 '(assert-equal? '((lambda (x y) (+ x y))
				   (lambda (x) x))
				 (definition-bodies
				   (collect-definitions inner-define-proc)))
		 '(assert-equal? '((u '*unassigned*) (v '*unassigned*))
				 (make-initial-bindings '(u v)))
		 '(assert-equal? '((set! u merong) (set! v haha))
				 (make-set!s '(u v)
					     '(merong haha)))
		 '(assert-equal?
		   '((sum (identity a) (identity b)))
		   (exclude-definitions (cddr inner-define-proc)))
		 ))

(run-named-test "TEST for b - scanned-out-proc"
		(make-testcase
		 '(assert-equal? (list (procedure-body scanned-out-proc))
				 (scan-out-defines
				  (cddr inner-define-proc)))
				       
		 '(assert-equal? 5
				 (myeval (list scanned-out-proc 2 3)
					 test-environment))
		 ))

(install-scan-out)
(run-named-test "TEST for c - intall scan-out-defines and test!"
		(make-testcase
		 '(assert-equal? 5
				 (myeval (list inner-define-proc 2 3)
					 test-environment))
		 ))