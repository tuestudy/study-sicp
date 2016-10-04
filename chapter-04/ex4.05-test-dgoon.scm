(load "../chapter-04/ex4.05-dgoon.scm")
(display "TEST for Legacy")(newline)
(load "../misc/myeval-test.scm")

(display "TEST for cond-actions") (newline)
(run (make-testcase
      '(assert-equal? '(a (b a))
                      (cond-actions '(a => b)))
      ))

(display "TEST for cond")(newline)
(run (make-testcase
      '(assert-equal? 2
                      (myeval '(cond (true (if true 2 3))
                                     (else 0)) test-environment))
      '(assert-equal? 3
                      (myeval '(cond (2 => (lambda (x) (+ x 1)))
                                     (else false)) test-environment))
      '(assert-equal? 'merong
                      (myeval '(cond (false => cadr)
                                     (else 'merong)) test-environment))
      ;      '(assert-equal? 2
      ;                      (myeval '(cond ((assoc 'b '((a 1) (b 2))) => cadr)
      ;                                     (else false)) test-environment))
      ))

