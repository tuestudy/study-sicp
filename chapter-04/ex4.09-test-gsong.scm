(load "ch4-myeval-pkg-gsong.scm")
(load "../misc/scheme-test-r5rs.scm")
(load "ex4.08-test-gsong.scm")

(define tge (setup-environment))

(define test-exp
  '(let ((a 0) (sum 0))
    (while (<= a 10)
           (begin (set! sum (+ sum a))
                  (set! a (+ a 1))
                  sum))))
  
(display "[ex4.09 - Tests]\n")
(run (make-testcase
      '(assert-equal? 'ok (myeval '(define a 10) tge))
      '(assert-equal? 10 (myeval 'a tge))
      '(assert-equal? 'ok (myeval '(set! a 11) tge))
      '(assert-equal? #t (myeval '(> a 0) tge))
     ; '(assert-equal? 9 (myeval '(begin (set! a (- a 1)) a) tge))
      '(assert-equal? 5 (myeval '(+ 2 3) tge))
      '(assert-equal? 5 (myeval '(let ((a 2) (b 3)) (+ a b)) tge))
      ;'(assert-equal? 36 (myeval '(while (> a 0) (begin (set! a (- a 1)) a)) tge))
      '(assert-equal? 5 (myeval '(+ 2 3) tge))
      '(assert-equal? 5 (myeval '(let ((a 2) (b 3)) (+ a b)) tge))
      ))