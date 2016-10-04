(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.81-falsetru.scm")

(install-scheme-number-package)
(install-rational-package)
(install-rectangular-package)
(install-polar-package)
(install-complex-package)

(define ex2.81-falsetru-tests
  (test-suite
   "Test for ex2.81-falsetru"

   ; a. run forever.
   ;(exp (make-complex-from-real-imag 1 0)
   ;     (make-complex-from-real-imag 1 0))
   ;
   ; (exp a b)
   ; = (apply-generic 'exp a b)
   ; = (apply-generic 'exp (complex->complex a) b)
   ; = (apply-generic 'exp a b)
   ; = (apply-generic 'exp (complex->complex a) b)
   ; ....
   ;
   ; b. -> c
   ;

   ; c
   (check-exn exn? (lambda () (exp (make-complex-from-real-imag 1 0)
                                   (make-complex-from-real-imag 1 0))))
   ))

(exit
  (cond
    ((= (run-tests ex2.81-falsetru-tests) 0))
    (else 1)))
