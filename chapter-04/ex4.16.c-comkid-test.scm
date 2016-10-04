(load "ch4-myeval-pkg-comkid.scm")
(load "ex4.11-comkid.scm")
(load "ex4.12-comkid.scm")
(load "ex4.13-comkid.scm")
(load "ex4.16.a-comkid.scm")
(load "ex4.16.b-comkid.scm")
(load "ex4.16.c-comkid.scm")
(load "../misc/scheme-test-r5rs.scm")

(define the-global-environment (setup-environment))

(myeval '(define (f x)
           (define (square a) (* a a))
           (define b 3)
           (+ b (square x)))
        the-global-environment)

(myeval '(define (double x) (* x 2)) the-global-environment)

(display "[ex4.17.c - Tests]\n")
(run (make-testcase
      '(assert-equal? 7 
                      (myeval '((lambda (x)
                                        (define (square a) (* a a))
                                        (define b 3)
                                        (+ b (square x))) 2) 
                              the-global-environment))
      '(assert-equal? 30
                      (myeval '((lambda (x) (define a 10) (define b 20) (+ a b)) 3) 
                              the-global-environment))
      '(assert-equal? 16 (myeval '(double 8) the-global-environment))
      ))
