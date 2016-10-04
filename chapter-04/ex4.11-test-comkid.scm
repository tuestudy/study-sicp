(load "ch4-myeval-pkg-comkid.scm")
(load "ex4.11-gsong.scm")
(load "../misc/scheme-test-r5rs.scm")

(define frame (make-frame '(a b c) '(1 2 3)))

(display "[ex4.11 - Tests]\n")
(run (make-testcase
      '(assert-equal? '((a 1) (b 2) (c 3)) frame)
      '(assert-equal? (list 'a 'b 'c) (frame-variables frame))
      '(assert-equal? (list '1 2 3) (frame-values frame))
      '(assert-equal? '((d 4) (a 1) (b 2) (c 3)) 
                      (begin (add-binding-to-frame! 'd 4 frame) 
                             frame))
      ))

(define the-global-environment (setup-environment))
(display "[ex4.11 - Tests 2]\n")

(myeval '(define a 2) the-global-environment)
(myeval '(define b (+ a 1)) the-global-environment)

(define test-env '())
(define test-env2 (extend-environment2 (make-frame '(a b c) '(1 2 3)) test-env))
(define test-env3 (extend-environment2 (make-frame '(x y z) '(4 5 6)) test-env2))

(run (make-testcase
      '(assert-equal? 2 (myeval 'a the-global-environment))
      '(assert-equal? 3 (myeval 'b the-global-environment))
      '(assert-equal? '(((x 4) (y 5) (z 6)) ((a 1) (b 2) (c 3))) test-env3)
      ))
