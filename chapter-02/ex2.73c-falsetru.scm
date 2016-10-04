(load "ex2.73b-falsetru.scm")

(define (install-deriv-exp-package)
  (define exponent cadr)
  (define base car)
  (define (** exp num)
    (cond ((=number? num 0) 1)
          ((=number? num 1) exp)
          ((and (number? exp) (number? num)) (expt exp num))
          (else (list '** exp num))))
  (put 'deriv '**
       (lambda (exp var)
         (make-product
           (make-product (exponent exp)
                         (** (base exp) (make-sum (exponent exp) -1)))
           (deriv (base exp) var)))))
(install-deriv-exp-package)
