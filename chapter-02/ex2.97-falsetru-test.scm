(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.97-falsetru.scm")

(install-scheme-number-package)
(install-rational-package)
(install-rectangular-package)
(install-polar-package)
(install-complex-package)
(install-polynomial-package)

(define p1 (make-polynomial 'x '((1 1) (0 1))))
(define p2 (make-polynomial 'x '((3 1) (0 -1))))
(define p3 (make-polynomial 'x '((1 1))))
(define p4 (make-polynomial 'x '((2 1) (0 -1))))

(define rf1 (make-rational p1 p2))
(define rf2 (make-rational p3 p4))

(define ex2.97-falsetru-tests
  (test-suite
   "Test for ex2.97-falsetru"

   (check-equal? (reduce 3 6)
                 (list 1 2))
   (check-equal?  (add (make-rational 3 4)
                       (make-rational 5 12))
                  (make-rational 7 6))
   (check-equal? (add rf1 rf2)
                 (make-rational
                   (make-polynomial 'x '((3 -1) (2 -2) (1 -3) (0 -1)))
                   (make-polynomial 'x '((4 -1) (3 -1) (1 1) (0 1)))))
    ))

(exit
  (cond
    ((= (run-tests ex2.97-falsetru-tests) 0))
    (else 1)))



