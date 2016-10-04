(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.37-falsetru.scm")

(define m
  '((1 2 3 4)
    (4 5 6 6)
    (6 7 8 9)))
(define n
  '((1 1 1)
    (1 1 1)
    (1 1 1)
    (1 1 1)))
(define ex2.37-falsetru-tests
  (test-suite
   "Test for ex2.37-falsetru"

   (check-equal? (dot-product '(1 2 3 4)
                              '(4 5 6 6))
                 (+ (* 1 4)
                    (* 2 5)
                    (* 3 6)
                    (* 4 6)))
   (check-equal? (matrix-*-vector m '(1 1 1 1))
                 (list (+ 1 2 3 4)
                       (+ 4 5 6 6)
                       (+ 6 7 8 9)))
   (check-equal? (transpose m)
                 '((1 4 6)
                   (2 5 7)
                   (3 6 8)
                   (4 6 9)))
   (check-equal? (matrix-*-matrix m n)
                 '((10 10 10)
                   (21 21 21)
                   (30 30 30)))
   ))

(exit
  (cond
    ((= (run-tests ex2.37-falsetru-tests) 0))
    (else 1)))
