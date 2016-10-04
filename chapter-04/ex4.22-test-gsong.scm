(load "ch4-myeval-pkg-gsong.scm")
(load "../misc/scheme-test-r5rs.scm")
(load "ex4.21-test-gsong.scm")
(load "ex4.22-gsong.scm")

(define tge (setup-environment))

(display "[ex4.22 - Tests]\n")
  
(run (make-testcase
      '(assert-equal? 7 (myeval '(+ 3 4) tge))
      '(assert-equal? 'ok (myeval '(quote ok) tge))
      '(assert-equal? 7 (myeval '(let ((a 3) (b 4)) (+ a b)) tge))
      ))
