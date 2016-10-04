(load "ch4-myeval-for-lazy-comkid.scm")
(load "ch4-force-it-with-memoization.scm")
(load "../misc/scheme-test-r5rs.scm")

(define the-global-environment (setup-environment))
(myeval '(define count 0) the-global-environment)
(myeval '(define (id x) 
           (set! count (+ count 1))
           x)
        the-global-environment)
(myeval '(define (square x) (* x x)) the-global-environment)

(run-named-test 
 "ex4.29 Test"
 (make-testcase
  '(assert-equal? 100 (myeval '(square (id 10)) the-global-environment))
  '(assert-equal? 1 (myeval 'count the-global-environment))
  ))
               


