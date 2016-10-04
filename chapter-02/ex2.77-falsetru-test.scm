(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.77-falsetru.scm")

(install-scheme-number-package)
(install-rational-package)
(install-rectangular-package)
(install-polar-package)
(install-complex-package)
(define ex2.77-falsetru-tests
  (test-suite
   "Test for ex2.77-falsetru"

   (test-case
    "magnitude of complex"
    (define complex-number (make-complex-from-real-imag 3 4))
    (define rectangular-complex (make-from-real-imag 3 4))

    (check-equal? complex-number (cons 'complex (cons 'rectangular (cons 3 4))))
    (check-equal? rectangular-complex (cons 'rectangular (cons 3 4)))

    (check-equal? (magnitude complex-number) 5)
    (check-equal? (apply-generic 'magnitude complex-number) 5)
    (check-equal? ((get 'magnitude '(complex)) (contents complex-number)) 5)
    (check-equal? ((get 'magnitude '(complex)) rectangular-complex) 5)
    (check-equal? (magnitude rectangular-complex) 5)
    (check-equal? (apply-generic 'magnitude rectangular-complex) 5)
    (check-equal? ((get 'magnitude '(rectangular)) (contents rectangular-complex)) 5)
    (check-equal? ((get 'magnitude '(rectangular)) (cons 3 4)) 5)
    ;(check-equal? (magnitude-inside-rectangular-package (cons 3 4)) 5)
    )
   ))

(exit
  (cond
    ((= (run-tests ex2.77-falsetru-tests) 0))
    (else 1)))
