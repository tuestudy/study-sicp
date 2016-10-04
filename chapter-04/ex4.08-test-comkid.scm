(load "ch4-myeval-pkg-comkid.scm")
(load "../misc/scheme-test-r5rs.scm")
(define the-global-environment (setup-environment))

(myeval '(define (fib n)
           (let fib-iter ((a 1)
                          (b 0)
                          (count n))
             (if (= count 0)
                 b
                 (fib-iter (+ a b) a (- count 1))))) the-global-environment)

(define input-exp '(let fib-iter ((a 1)
                                  (b 0)
                                  (count n))
                     (if (= count 0)
                         b
                         (fib-iter (+ a b) a (- count 1)))))

(define expected-exp '(begin 
                        (define (fib-iter a b count) 
                          (if (= count 0)
                              b
                              (fib-iter (+ a b) a (- count 1))))
                        (fib-iter 1 0 n)))

(display "[ex4.08 - Tests]\n")
(run (make-testcase
      '(assert-equal? expected-exp (named-let->combination input-exp))
      '(assert-equal? 0 (myeval '(fib 0) the-global-environment))
      '(assert-equal? 1 (myeval '(fib 1) the-global-environment))
      '(assert-equal? 1 (myeval '(fib 2) the-global-environment))
      '(assert-equal? 2 (myeval '(fib 3) the-global-environment))
      ))

