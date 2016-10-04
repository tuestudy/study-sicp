(load "ch4-myeval-pkg-gsong.scm")
(load "../misc/scheme-test-r5rs.scm")
(load "ex4.09-test-gsong.scm")

;(myeval '(define (sum a b) (+ a b)) tge)
;(myeval '(sum 3 4) tge)
(define tge (setup-environment))

(define testlist '((a 1) (b 2)))

(display "[ex4.11 - Tests]\n")
(run (make-testcase
      '(assert-equal? #t (begin (add-binding-to-frame! 'c 3 testlist) #t))
      '(assert-equal? '((c 3) (a 1) (b 2)) testlist )
      '(assert-equal? '((1 a) (2 b) (3 c)) (make-frame '(1 2 3) '(a b c)))
      '(assert-equal? #f (null? (lookup-variable-value 'cdr tge)))
      '(assert-equal? #f (eq? #f (define-variable! 'xyz 333 tge)))
      '(assert-equal? #f (null? (lookup-variable-value 'xyz tge)))
      '(assert-equal? #f (eq? #f (define-variable! 'x 10 tge)))
      '(assert-equal? #f (null? (lookup-variable-value 'xyz tge)))
      '(assert-equal? #f (eq? #f (set-variable-value! 'xyz 666 tge)))
      '(assert-equal? 666 (myeval 'xyz tge))
      '(assert-equal? 'ok (myeval '(define a 66) tge))
      '(assert-equal? 'ok (myeval '(define b 11) tge))
      '(assert-equal? 666 (myeval 'xyz tge))
      
      '(assert-equal? '((1 a) (2 b) (3 c)) (make-pair '(1 2 3) '(a b c)))
      
       ; let tests
      '(assert-equal? 3 (myeval '(+ 2 1) tge))
      '(assert-equal? 3 (myeval '(let ((a 1) (b 2)) (+ a b)) tge))
      ))
