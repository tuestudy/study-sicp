(load "ex4.04-dgoon-again.scm")

(display "TEST - ex4.04")(newline)
(run (make-testcase
      '(assert-false? (myeval '(and (= a 1) (= b 1)) test-environment))
      '(assert-true? (myeval '(and (= a 1) (= b 2)) test-environment))))

(run (make-testcase
      '(assert-false? (myeval '(and2 (= a 1) (= b 1)) test-environment))
      '(assert-true? (myeval '(and2 (= a 1) (= b 2)) test-environment))))

(run (make-testcase
      '(assert-false? (myeval '(or (= a 2) (= b 1)) test-environment))
      '(assert-true? (myeval '(or (= a 1) (= b 2)) test-environment))))

(run (make-testcase
      '(assert-false? (myeval '(or2 (= a 2) (= b 1)) test-environment))
      '(assert-true? (myeval '(or2 (= a 1) (= b 2)) test-environment))))
