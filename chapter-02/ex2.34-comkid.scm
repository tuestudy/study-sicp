(load "../misc/scheme-test.scm")

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms) (+ (* higher-terms x) this-coeff))
              0
              coefficient-sequence))

(run (make-testcase 
      '(assert-equal? 1 (horner-eval 0 (list 1 3 0 5 0 1)))
      '(assert-equal? 79 (horner-eval 2 (list 1 3 0 5 0 1)))
      '(assert-equal? 10 (horner-eval 1 (list 1 3 0 5 0 1)))
      ))