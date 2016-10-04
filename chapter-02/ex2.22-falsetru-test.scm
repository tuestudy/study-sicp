(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.22-falsetru.scm")

(define items (list 1 2 3 4))

(define ex2.22-falsetru-tests
  (test-suite
   "Test for ex2.22-falsetru"

   (check-not-equal? (square-list3 items)
                     (square-list1 items))
   (check-not-equal? (square-list4 items)
                     (square-list1 items))
   (check-equal? (square-list5 items)
                 (square-list1 items))
   (check-equal? (square-list6 items)
                 (square-list1 items))
   (check-equal? (cons 1 (list 2)) '(1 2))
   (check-equal? (cons (list 1) 2) '((1) . 2))
   ))

(exit
  (cond
    ((= (run-tests ex2.22-falsetru-tests) 0))
    (else 1)))
