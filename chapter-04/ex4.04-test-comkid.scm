(load "ch4-myeval-pkg-comkid.scm")
(load "../misc/scheme-test-r5rs.scm")
(define the-global-environment (setup-environment))
(display "[ex4.04 - Tests]\n")
(run (make-testcase
      ; and
      '(assert-equal? true (myeval '(and) the-global-environment))
      '(assert-equal? 1 (myeval '(and 1) the-global-environment))
      '(assert-equal? false (myeval '(and false) the-global-environment))
      '(assert-equal? 3 (myeval '(and 1 3) the-global-environment))
      '(assert-equal? 6 (myeval '(and 1 3 4 6) the-global-environment))
      '(assert-equal? false (myeval '(and 1 3 4 6 false) the-global-environment))
      ; or
      '(assert-equal? false (myeval '(or) the-global-environment))
      '(assert-equal? 1 (myeval '(or 1) the-global-environment))
      '(assert-equal? 3 (myeval '(or 3 1 2 3 false) the-global-environment))
      '(assert-equal? 5 (myeval '(or false false false false 5) the-global-environment))
      ))