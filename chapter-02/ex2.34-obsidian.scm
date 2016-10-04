(load "../misc/scheme-test.scm")

(define (horner-eval x coefficient-sequence)
  (foldr (lambda (this-coeff higher-terms)
           (+ (* higher-terms x) this-coeff))
         0
         coefficient-sequence))


(run (make-testcase
      '(assert-equal? (+ 1 1) 2)
      '(assert-equal? (horner-eval 2 (list 1 3 0 5 0 1)) 79)
      ))
