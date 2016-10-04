(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.87-falsetru.scm")

(install-scheme-number-package)
(install-rational-package)
(install-rectangular-package)
(install-polar-package)
(install-complex-package)
(install-polynomial-package)

(define p1 (make-polynomial 'x '((4 1) (3 -1) (2 -2) (1 2))))
(define p2 (make-polynomial 'x '((3 1) (1 -1))))

(define ex2.94-falsetru-tests
  (test-suite
   "Test for ex2.94-falsetru"

   (check-equal? (greatest-common-divisor 6 4) 2)
   (check-equal? (greatest-common-divisor p1 p2)
                 (make-polynomial 'x '((2 -1) (1 1))))

   ))

(exit
  (cond
    ((= (run-tests ex2.94-falsetru-tests) 0))
    (else 1)))
