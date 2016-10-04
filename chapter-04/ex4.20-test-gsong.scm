(load "ch4-myeval-pkg-gsong.scm")
(load "../misc/scheme-test-r5rs.scm")
(load "ex4.16-test-gsong.scm")

(define tge (setup-environment))

(display "[ex4.20 - Tests]\n")

(define test_exp_1
  '(letrec
       ((a 1)
        (b 2))
     (+ a b)))

(define expected_exp_1
  '(let
       ((a *unassigned*)
        (b *unassigned*))
     (begin
       (set! a 1)
       (set! b 2)
       (+ a b))))

(define test_exp_2
  '(letrec ((fact
          (lambda (n)
            (if (= n 1)
                1
                (* n (fact (- n 1)))))))
  (fact 10)))

(define expected_exp_2
  '(let
       ((fact *unassigned*))
     (begin
       (set! fact (lambda (n)
                    (if (= n 1)
                        1
                        (* n (fact (- n 1))))))
       (fact 10))))

(define test_exp_3
  '(letrec ((even?
            (lambda (n)
              (if (= n 0)
                  true
                  (odd? (- n 1)))))
           (odd?
            (lambda (n)
              (if (= n 0)
                  false
                  (even? (- n 1))))))
     (even? 4)))

(define expected_exp_3
  '(let
       ((even? *unassigned*)
        (odd? *unassigned*))
     (begin
       (set! even? (lambda (n)
              (if (= n 0)
                  true
                  (odd? (- n 1)))))
       (set! odd? (lambda (n)
              (if (= n 0)
                  false
                  (even? (- n 1)))))
       (even? 4))))

(define test_exp_4
  '(define (f x)
     (letrec ((even?
               (lambda (n)
                 (if (= n 0)
                     true
                     (odd? (- n 1)))))
              (odd?
               (lambda (n)
                 (if (= n 0)
                     false
                     (even? (- n 1))))))
       (even? x))))

(run (make-testcase
      '(assert-equal? '((a *unassigned*) (b *unassigned*)) (unassigned-letrec-vars (cadr test_exp_1)))
      '(assert-equal? '(begin (set! a 1) (set! b 2) (+ a b)) (make-set-and-body test_exp_1))
      '(assert-equal? expected_exp_1 (letrec->let test_exp_1))
      '(assert-equal? expected_exp_2 (letrec->let test_exp_2))
      '(assert-equal? expected_exp_3 (letrec->let test_exp_3))
      '(assert-equal? 'ok (myeval test_exp_4 tge))
      '(assert-equal? #t (myeval '(f 4) tge))
      '(assert-equal? #f (myeval '(f 3) tge))
      ))
