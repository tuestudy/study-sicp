(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.58-falsetru.scm")

(define ex2.58-falsetru-tests
  (test-suite
   "Test for ex2.58-falsetru"

   ; a
   (check-equal? (deriv '(x + (3 * (x + (y + 2)))) 'x)
                 4)
   (check-equal? (deriv '(x + (3 * (x + (y + 2)))) 'y)
                 3)
   (check-equal? (deriv '(x + (3 * (x + (y + 2)))) 'z)
                 0)

   (check-equal? (deriv '(x ** 3) 'x)
                 '(3 * (x ** 2)))

   (check-equal? (deriv '((x ** 2) + x) 'x)
                 '((2 * x) + 1))

   ; b
   (check-equal? (deriv '(x + 3 * (x + y + 2)) 'x)
                 4)

   (check-equal? (addend '(x + y + z)) '(y + z))
   (check-equal? (addend '(x + (y + z))) '(y + z))
   ))

(exit
  (cond
    ((= (run-tests ex2.58-falsetru-tests) 0))
    (else 1)))
