(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.96b-falsetru.scm")

(install-scheme-number-package)
(install-rational-package)
(install-rectangular-package)
(install-polar-package)
(install-complex-package)
(install-polynomial-package)

(define P1 (make-polynomial 'x '((2 1) (1 -2) (0 1))))
(define P2 (make-polynomial 'x '((2 11) (0 7))))
(define P3 (make-polynomial 'x '((1 13) (0 5))))

(define Q1 (mul P1 P2))
(define Q2 (mul P1 P3))

(define ex2.96b-falsetru-tests
  (test-suite
   "Test for ex2.96b-falsetru"

;    (check-equal? (gcd-terms '((4 11) (3 -22) (2 18) (1 -14) (0 7))
;                             '((3 13) (2 -21) (1 3) (0 5)))
;                  '((2 1) (1 -2) (0 1)))
    (check-equal? (greatest-common-divisor Q1 Q2)
                   (make-polynomial 'x '((2 1) (1 -2) (0 1))))
    ))

(exit
  (cond
    ((= (run-tests ex2.96b-falsetru-tests) 0))
    (else 1)))


