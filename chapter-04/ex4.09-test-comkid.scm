(load "ch4-myeval-pkg-comkid.scm")
(load "../misc/scheme-test-r5rs.scm")

(define the-global-environment (setup-environment))

(define while-exp 
  '(while ((result 1) (n 5)) 
          (lambda (x) (> x 1)) 
          ((* result n)
           (- n 1))))

(define expected-exp
  '(let iter ((result 1)
              (n 5))
     (if ((lambda (x) (> x 1)) n) 
         (iter (* result n) (- n 1))
         result)))


(display "[ex4.09 - Tests]\n")
(run (make-testcase
      '(assert-equal? expected-exp (while->named-let while-exp))
      '(assert-equal? 120 (myeval expected-exp the-global-environment))
      ))

