(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.14-falsetru.scm")

(define ex2.14-falsetru-tests
  (test-suite
   "Test for ex2.14-falsetru"

   (test-case
    "par1 != par2"

    (define r1 (make-center-width 5 0.0001))
    (define r2 (make-center-width 10 0.0001))
    (check-= (center (par1 r1 r2))
             (center (par2 r1 r2))
             0.0001)
;    (check-= (percent (par1 r1 r2))
;             (percent (par2 r1 r2))
;             0.0001)
     (check-true (> (abs (- (percent (par1 r1 r2))
                            (percent (par2 r1 r2))))
                    0.0001))
    )
   (check-equal? 1 1)
   ))

(exit
  (cond
    ((= (run-tests ex2.14-falsetru-tests) 0))
    (else 1)))
