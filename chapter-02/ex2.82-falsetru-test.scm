(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.82-falsetru.scm")

(install-scheme-number-package)
(install-rational-package)
(install-rectangular-package)
(install-polar-package)
(install-complex-package)

(define a (make-scheme-number 1))
(define b (make-scheme-number 0))
(define c (make-rational 1 2))
(define d (make-rational 1 2))
(define e (make-complex-from-real-imag 1 1))

(define ex2.82-falsetru-tests
  (test-suite
   "Test for ex2.82-falsetru"

   (check-equal? (conv a 'scheme-number) a)
   (check-equal? (conv a 'rational) (make-rational 1 1))
   (check-equal? (conv e 'scheme-number) false)

   (check-equal? (repeat 4 'x) '(x x x x))

   (check-true (all '(1 1 1 1)))
   (check-false (all (list 1 false 1 1)))

   (test-case "add4"

    (check-equal? (add a b) (make-scheme-number 1))
    (check-equal? (add c d) (make-rational 2 2))
    (check-equal? (add4 a b c d) (make-rational 2 1)) 
    (check-exn exn? (lambda () (add4 a b c e)))
    ;(add4 a b c e)
    (check-equal? 1 1)
    )
   
   ))

(exit
  (cond
    ((= (run-tests ex2.82-falsetru-tests) 0))
    (else 1)))
