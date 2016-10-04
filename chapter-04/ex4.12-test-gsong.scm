(load "ch4-myeval-pkg-gsong.scm")
(load "../misc/scheme-test-r5rs.scm")
(load "ex4.11-test-gsong.scm")

(define tge (setup-environment))

(define testlist '((a 1) (b 2) (c 3)))
(display "[ex4.12 - Tests]\n")
(run (make-testcase
      '(assert-equal? #t (begin (add-binding-to-frame! 'd 5 testlist) #t))
      '(assert-equal? '((d 5) (a 1) (b 2) (c 3)) testlist)
      '(assert-equal? #f (null? (lookup-variable-value 'cdr tge)))
      '(assert-equal? #t (null? (lookup-variable-value 'xyz tge)))
      '(assert-equal? #f (eq? #f (define-variable! 'xyz 333 tge)))
      '(assert-equal? #f (null? (lookup-variable-value 'xyz tge)))
      '(assert-equal? #f (eq? #f (set-variable-value! 'xyz 666 tge)))
      '(assert-equal? 666 (myeval 'xyz tge))
      
      ; let tests
      '(assert-equal? 3 (myeval '(+ 2 1) tge))
      '(assert-equal? 3 (myeval '((lambda () (+ 1 2))) tge))
      '(assert-equal? 3 (myeval '(let () (+ 1 2)) tge))
      '(assert-equal? 3 (myeval '(let ((a 1) (b 2)) (+ a b)) tge))
      '(assert-equal? 'ok (myeval '(define (testfunc x) (+ x 1))  tge))
      '(assert-equal? 5 (myeval '(testfunc 4) tge))
      ))
