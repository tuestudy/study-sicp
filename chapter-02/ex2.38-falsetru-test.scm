(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.38-falsetru.scm")

(define ex2.38-falsetru-tests
  (test-suite
   "Test for ex2.38-falsetru"

   (check-equal? (fold-left2 + 0 '(1 2 3 4 5)) 15)

   (check-equal? (fold-right2 / 1 (list)) 1)
   (check-equal? (fold-right2 / 1 (list 3)) 3)
   (check-equal? (fold-right2 / 1 (list 2 3)) (/ 2 3))
   (check-equal? (fold-right2 / 1 (list 1 2 3)) (/ 3 2))

   (check-equal? (fold-left2 / 1 (list)) 1)
   (check-equal? (fold-left2 / 1 (list 1)) 1)
   (check-equal? (fold-left2 / 1 (list 1 2)) (/ 1 2))
   (check-equal? (fold-left2 / 1 (list 1 2 3)) (/ 1 6))

   (check-equal? (fold-right2 list null (list)) null)
   (check-equal? (fold-right2 list null (list 3)) (list 3 null))
   (check-equal? (fold-right2 list null (list 2 3)) (list 2 (list 3 null)))
   (check-equal? (fold-right2 list null (list 1 2 3)) (list 1 (list 2 (list 3 null))))

   (check-equal? (fold-left2 list null (list)) null)
   (check-equal? (fold-left2 list null (list 1)) (list null 1))
   (check-equal? (fold-left2 list null (list 1 2)) (list (list null 1) 2))
   (check-equal? (fold-left2 list null (list 1 2 3)) (list (list (list null 1) 2) 3))
   ))

(exit
  (cond
    ((= (run-tests ex2.38-falsetru-tests) 0))
    (else 1)))
