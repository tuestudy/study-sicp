(load "ch4-myeval-pkg-comkid.scm")
(load "ex4.11-comkid.scm")
(load "ex4.12-comkid.scm")
(load "../misc/scheme-test-r5rs.scm")

(define the-global-environment (setup-environment))
(display "[ex4.12 - Tests]\n")

(myeval '(define a 2) the-global-environment)
(myeval '(define b (+ a 1)) the-global-environment)
(myeval '(set! b (* b 2)) the-global-environment)

(run (make-testcase
      '(assert-equal? 2 (myeval 'a the-global-environment))
      '(assert-equal? 6 (myeval 'b the-global-environment))
      '(assert-equal? 3 (myeval '(begin (define a 3) 
                                        a) 
                                the-global-environment))
      ))
