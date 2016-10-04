(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.88-falsetru.scm")

(install-scheme-number-package)
(install-rational-package)
(install-rectangular-package)
(install-polar-package)
(install-complex-package)
(install-polynomial-package)

(define ex2.88-falsetru-tests
  (test-suite
   "Test for ex2.88-falsetru"

   (check-equal? (neg (make-scheme-number 1)) (make-scheme-number -1))
   (check-equal? (neg (make-rational 1 1)) (make-rational -1 1))
   (check-equal? (neg (make-complex-from-real-imag 1 1))
                 (make-complex-from-real-imag -1 -1))
   (check-equal? (neg (make-polynomial 'x '((1 1) (0 1))))
                 (make-polynomial 'x '((1 -1) (0 -1))))
   (check-equal? (sub (make-polynomial 'x '((1 3) (0 5)))
                      (make-polynomial 'x '((1 1) (0 1))))
                 (make-polynomial 'x '((1 2) (0 4))))
   ))

(exit
  (cond
    ((= (run-tests ex2.88-falsetru-tests) 0))
    (else 1)))
