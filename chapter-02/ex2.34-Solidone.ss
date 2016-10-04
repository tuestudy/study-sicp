(load "scheme-test.scm")

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (horner-eval x sequence)
  (accumulate (lambda (this-coeff higher-terms)
                (+ this-coeff
                   (* x higher-terms)))
              0
              sequence))

; <??> : (+ this-coeff (* x higher-terms))

(= (+ 1 (* 3 2) (* 5 (expt 2 3)) (expt 2 5))
   (horner-eval 2 (list 1 3 0 5 0 1)))