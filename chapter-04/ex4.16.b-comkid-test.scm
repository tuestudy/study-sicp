(load "ch4-myeval-pkg-comkid.scm")
(load "ex4.11-comkid.scm")
(load "ex4.12-comkid.scm")
(load "ex4.13-comkid.scm")
(load "ex4.16.a-comkid.scm")
(load "ex4.16.b-comkid.scm")
(load "../misc/scheme-test-r5rs.scm")

(define the-global-environment (setup-environment))

(define internal-exp1
  '((define a 1)
    (define b 2)
    (+ x a b)))
(define expected-exp1
  '((let ((a '*unassigned*)
         (b '*unassigned*))
     (set! a 1)
     (set! b 2)
     (+ x a b))))

(define internal-exp2
  '((define (inc a) (+ a 1))
    (inc x)))

(define expected-exp2
  '((let ((inc '*unassigned*))
     (set! inc (lambda (a) (+ a 1)))
     (inc x))))

(define internal-exp3
  '((define (inc a) (+ a 1))
    (define b 3)
    (+ b (inc x))))

(define expected-exp3
  '((let ((inc '*unassigned*)
         (b '*unassigned*))
     (set! inc (lambda (a) (+ a 1)))
     (set! b 3)
     (+ b (inc x)))))

(display "[ex4.17.b - Tests]\n")
(run (make-testcase
      '(assert-equal? expected-exp1 (scan-out-defines internal-exp1))
      '(assert-equal? expected-exp2 (scan-out-defines internal-exp2))
      '(assert-equal? expected-exp3 (scan-out-defines internal-exp3))
      ))