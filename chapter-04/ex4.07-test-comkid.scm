(load "ch4-myeval-pkg-comkid.scm")
(load "../misc/scheme-test-r5rs.scm")
(define the-global-environment (setup-environment))

(define input-exp '(let* ((x 3)
                          (y (+ x 2))
                          (z (+ x y 5)))
                     (* x z)))
(define expected-exp '(let ((x 3))
                        (let ((y (+ x 2)))
                          (let ((z (+ x y 5)))
                            (* x z)))))

(display "[ex4.07 - Tests]\n")
(run (make-testcase
      '(assert-equal? expected-exp (let*->nested-lets input-exp))
      '(assert-equal? 39 (myeval input-exp the-global-environment))
      ))

