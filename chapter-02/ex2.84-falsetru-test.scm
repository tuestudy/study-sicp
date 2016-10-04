(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.84-falsetru.scm")

(install-scheme-number-package)
(install-rational-package)
(install-rectangular-package)
(install-polar-package)
(install-complex-package)


(define ex2.84-falsetru-tests
  (test-suite
   "Test for ex2.84-falsetru"

   (test-case "higher"
    (check-true (higher 'complex 'scheme-number))
    (check-true (higher 'complex 'rational))
    (check-true (higher 'rational 'scheme-number))
    (check-false (higher 'rational 'rational))
    (check-false (higher 'scheme-number 'rational)))
   (test-case "coerce, add"
    (define a (make-scheme-number 1))
    (define b (make-complex-from-real-imag 1 0))
    (define c (make-scheme-number 2))
    (define d (make-rational 1 2))
    (check-equal? (coerce a b) (list b b))
    (check-equal? (coerce b a) (list b b))
    (check-equal? (coerce a c) (list a c))
    (check-equal? (coerce c a) (list c a))

    (check-equal? (add a b) (make-complex-from-real-imag 2 0))
    (check-equal? (add a a) (make-scheme-number 2))
    (check-equal? (add a d) (make-rational 3 2))
    )
   ))

(exit
  (cond
    ((= (run-tests ex2.84-falsetru-tests) 0))
    (else 1)))
