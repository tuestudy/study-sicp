(load "ch4-myeval-pkg-gsong.scm")
(load "../misc/scheme-test-r5rs.scm")
(load "ex4.12-test-gsong.scm")

(define tge (setup-environment))

(define testlist '((a 1) (b 2) (c 3) (d 4)))

(display "[ex4.13 - Tests]\n")
(run (make-testcase
      '(assert-equal? #t (remove-first-from-list testlist))
      
      '(assert-equal? '((b 2) (c 3) (d 4)) testlist)
      '(assert-equal? #f (remove-binding-from-frame! 'x testlist))
      '(assert-equal? #t (remove-binding-from-frame! 'c testlist))
      '(assert-equal? '((b 2) (d 4)) testlist)
      '(assert-equal? #t (remove-binding-from-frame! 'b testlist))
      '(assert-equal? '((d 4)) testlist)
      
      '(assert-equal? 'ok (myeval '(define x13 101) tge))
      '(assert-equal? #t (undefine! 'x13 tge))
      '(assert-equal? '() (myeval (make-unbound! 'x13 tge) tge))
      
      '(assert-equal? 'ok (myeval '(define y13 101) tge))
      '(assert-equal? #t (myeval (make-unbound! 'y13 tge) tge))
      
      ; let tests
      '(assert-equal? 3 (myeval '(+ 2 1) tge))
      '(assert-equal? 3 (myeval '(let ((a 1) (b 2)) (+ a b)) tge))
      ))

(define env (extend-environment '(x) '(1) tge))
(make-unbound! 'x env)
(myeval 'x env)