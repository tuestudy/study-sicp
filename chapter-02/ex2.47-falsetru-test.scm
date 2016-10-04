(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.47-falsetru.scm")

(define v1 (make-vector1 0 0))
(define v2 (make-vector1 1 2))
(define v3 (make-vector1 2 3))
(define f1 (make-frame-1 v1 v2 v3))
(define f2 (make-frame-2 v1 v2 v3))

(define ex2.47-falsetru-tests
  (test-suite
   "Test for ex2.47-falsetru"

   (check-equal? (origin-frame-1 f1) v1)
   (check-equal? (edge1-frame-1  f1) v2)
   (check-equal? (edge2-frame-1  f1) v3)

   (check-equal? (origin-frame-2 f2) v1)
   (check-equal? (edge1-frame-2  f2) v2)
   (check-equal? (edge2-frame-2  f2) v3)
   ))

(exit
  (cond
    ((= (run-tests ex2.47-falsetru-tests) 0))
    (else 1)))
