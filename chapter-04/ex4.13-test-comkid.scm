(load "ch4-myeval-pkg-comkid.scm")
(load "ex4.11-comkid.scm")
(load "ex4.12-comkid.scm")
(load "ex4.13-comkid.scm")
(load "../misc/scheme-test-r5rs.scm")

(define the-global-environment (setup-environment))

(display "[ex4.13 - Tests 1]: simple unbound\n")
(myeval '(define (two k)
           (if (eq? 'ok (make-unbound! k))
               2
               k))
        the-global-environment)

(run (make-testcase
      '(assert-equal? 'ok (myeval '(define a 1) the-global-environment))
      '(assert-equal? 1 (myeval 'a the-global-environment))
      '(assert-equal? 'ok (myeval '(make-unbound! a) the-global-environment))
      '(assert-equal? 'fail (myeval '(make-unbound! a) the-global-environment))
      '(assert-equal? 'fail (myeval '(make-unbound! b) the-global-environment))
      '(assert-equal? 2 (myeval '(two 10) the-global-environment))
      ))

(display "[ex4.13 - Tests 2]: unbound scope\n")
(myeval '(define x 1) the-global-environment)
(myeval '(define (sub x y)
           (make-unbound! x)
           (- x y))
        the-global-environment)
(myeval '(define i 10) the-global-environment)
(myeval '(define (self j)
           (make-unbound! i)
           j)
        the-global-environment)

(run (make-testcase
      '(assert-equal? -4 (myeval '(sub 3 5) the-global-environment))
      '(assert-equal? 5 (myeval '(self 5) the-global-environment))
      '(assert-equal? 10 (myeval 'i the-global-environment))
      ))
