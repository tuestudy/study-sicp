(load "ch4-myeval-pkg-gsong.scm")
(load "../misc/scheme-test-r5rs.scm")
(load "ex4.23-test-gsong.scm")

(define tge (setup-environment))

(display "[ex4.26 - Tests]\n")

(define testexp 
  '(unless (= 0 0) (/ 5 0) 1))
(define expected_exp
  '(if (= 0 0) 1 (/ 5 0)))


(define (unless->combination exp)
  (let 
      ((condition (cadr exp))
       (exceptional (cadddr exp))
       (usual (caddr exp)))
  (make-if condition exceptional usual)))

(run (make-testcase
      '(assert-equal? expected_exp (unless->combination testexp))
      ))

