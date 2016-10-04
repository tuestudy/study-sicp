(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.87-falsetru.scm")

(install-scheme-number-package)
(install-rational-package)
(install-rectangular-package)
(install-polar-package)
(install-complex-package)
(install-polynomial-package)

(define div-poly (get 'div 'poly))

(define ex2.91-falsetru-tests
  (test-suite
   "Test for ex2.91-falsetru"

   (check-equal?
     (div-poly (make-poly 'x '((1 1)))
               (make-poly 'x '((1 1))))
     (list (make-poly 'x '((0 1))) (make-poly 'x '())))

   (check-equal?
     (div-poly (make-poly 'x '((1 1) (0 1)))
               (make-poly 'x '((1 1))))
     (list (make-poly 'x '((0 1))) (make-poly 'x '((0 1)))))

   ))

(exit
  (cond
    ((= (run-tests ex2.91-falsetru-tests) 0))
    (else 1)))
