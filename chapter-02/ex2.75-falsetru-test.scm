(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.75-falsetru.scm")

(define ex2.75-falsetru-tests
  (test-suite
   "Test for ex2.75-falsetru"

   (check-equal? (apply-generic 'magnitude (make-from-mag-ang 1 0)) 1)
   (check-equal? (apply-generic 'angle     (make-from-mag-ang 1 0)) 0)
   (check-equal? (apply-generic 'real-part (make-from-mag-ang 1 0)) 1)
   (check-equal? (apply-generic 'imag-part (make-from-mag-ang 1 0)) 0)
   (check-exn exn?
              (lambda () (apply-generic 'no-such-op (make-from-mag-ang 1 0))))
   ))

(exit
  (cond
    ((= (run-tests ex2.75-falsetru-tests) 0))
    (else 1)))
