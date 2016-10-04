(load "ch4-myeval-pkg-gsong.scm")
(load "../misc/scheme-test-r5rs.scm")
(load "ex4.20-test-gsong.scm")

(define tge (setup-environment))

(display "[ex4.21 - Tests]\n")

;a
(define test_exp_1
  '((lambda (n)
      ((lambda (fact)
         (fact fact n))
       (lambda (ft k)
         (if (= k 1)
             1
             (* k (ft ft (- k 1)))))))
    10))

(define test_exp_a
  '((lambda (n)
      ((lambda (fib)
         (fib fib 1 0 n))
       (lambda (fb a b k)
         (if (= k 0)
             b
             (fb fb (+ a b) a (- k 1))))))
    10))

;b
(define test_exp_b
  '(define (f x)
     ((lambda (even? odd?)
        (even? even? odd? x))
      (lambda (ev? od? n)
        (if (= n 0) true (od? ev? od? (- n 1))))
      (lambda (ev? od? n)
        (if (= n 0) false (ev? ev? od? (- n 1)))))))
  
(run (make-testcase
      '(assert-equal? 3628800 (myeval test_exp_1 tge))
      '(assert-equal? 55 (myeval test_exp_a tge))
      '(assert-equal? 'ok (myeval test_exp_b tge))
      '(assert-equal? #t (myeval '(f 4) tge))
      '(assert-equal? #f (myeval '(f 5) tge))
      ))
