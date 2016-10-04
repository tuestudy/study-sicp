(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.83-falsetru.scm")

(install-scheme-number-package)
(install-rational-package)
(install-rectangular-package)
(install-polar-package)
(install-complex-package)


(define ex2.83-falsetru-tests
  (test-suite
   "Test for ex2.83-falsetru"

   (check-equal? (raise (make-scheme-number 1))
                 (make-rational 1 1))
   (check-equal? (raise (raise (make-scheme-number 1)))
                 (make-complex-from-real-imag 1 0))
   (check-equal? (raise (make-rational 1 1))
                 (make-complex-from-real-imag 1 0))
   (check-exn exn? (lambda ()
                     (raise (make-complex-from-real-imag 1 0))))
   ))

(exit
  (cond
    ((= (run-tests ex2.83-falsetru-tests) 0))
    (else 1)))
