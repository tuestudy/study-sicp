(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.93-falsetru.scm")

(install-scheme-number-package)
(install-rational-package)
(install-rectangular-package)
(install-polar-package)
(install-complex-package)
(install-polynomial-package)

(define p1 (make-polynomial 'x '((2 1) (0 1))))
(define p2 (make-polynomial 'x '((3 1) (0 1))))
(define rf (make-rational p2 p1))

(define p3 (make-polynomial 'x '((1 1) (0 1))))
(define p4 (make-polynomial 'x '((3 1) (0 -1))))
(define p5 (make-polynomial 'x '((1 1))))
(define p6 (make-polynomial 'x '((2 1) (0 -1))))
(define r1 (make-rational p3 p4))
(define r2 (make-rational p5 p6))

(define ex2.93-falsetru-tests
  (test-suite
   "Test for ex2.93-falsetru"

   (check-equal? (add rf rf)
                 (make-rational (make-polynomial 'x '((5 2) (3 2) (2 2) (0 2)))
                                (make-polynomial 'x '((4 1) (2 2) (0 1)))))

   (check-equal? (add r1 r2)
                 (make-rational (make-polynomial 'x '((4 1) (3 1) (2 1) (1 -2) (0 -1)))
                                (make-polynomial 'x '((5 1) (3 -1) (2 -1) (0 1)))))
   ))

(exit
  (cond
    ((= (run-tests ex2.93-falsetru-tests) 0))
    (else 1)))
