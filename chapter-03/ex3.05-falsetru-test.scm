(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex3.05-falsetru.scm")

(define ex3.05-falsetru-tests
  (test-suite
   "Test for ex3.05-falsetru"

   (check-true 
     (< (abs (- (/ (estimate-integral P 0 1000 0 1000 10000000)
                   (* 500.0 500.0))
                pi))
        0.01))
   ))

(exit
  (cond
    ((= (run-tests ex3.05-falsetru-tests) 0))
    (else 1)))
