(load "../misc/scheme-test.scm")
(load "../misc/accumulate.scm")

(define nil '())

(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms) (+ (* x higher-terms) this-coeff))
              0
              coefficient-sequence))

(run
 (make-testcase
  '(assert-equal? 79 (horner-eval 2 (list 1 3 0 5 0 1)))))
