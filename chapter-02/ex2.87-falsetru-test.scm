(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.87-falsetru.scm")

(install-scheme-number-package)
(install-rational-package)
(install-rectangular-package)
(install-polar-package)
(install-complex-package)
(install-polynomial-package)

(define a (make-polynomial 'x '((1 1) (0 1))))
(define b (make-polynomial 'x '((1 2))))

(define ex2.87-falsetru-tests
  (test-suite
   "Test for ex2.87-falsetru"

   (check-true (=zero? (make-polynomial 'x '())))
   (check-equal? (add a b) (make-polynomial 'x '((1 3) (0 1))))
   ))

(exit
  (cond
    ((= (run-tests ex2.87-falsetru-tests) 0))
    (else 1)))
