(load "ch4-myeval-pkg-gsong.scm")
(load "../misc/scheme-test-r5rs.scm")
(load "ex4.13-test-gsong.scm")

(define tge (setup-environment))

;(myeval '(set-variable-value! 'map mymap tge) tge)
(define testexp 
  '(map car '((a 1) (b 2) (c 3))))

(display "[ex4.14 - Tests]\n")
(run (make-testcase
      '(assert-equal? '(a b c) (myeval testexp tge))
      
      ; let tests
      '(assert-equal? 1 (myeval '(car '(1 a)) tge))
      '(assert-equal? 3 (myeval '(+ 2 1) tge))
      '(assert-equal? 3 (myeval '(let ((a 1) (b 2)) (+ a b)) tge))
      ))