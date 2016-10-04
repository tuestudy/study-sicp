(load "ch4-myeval-pkg-gsong.scm")
(load "../misc/scheme-test-r5rs.scm")
(define tge (setup-environment))

(define input-exp-let-combination
  '(let fib-iter ((a 1)
                  (b 0)
                  (count 7))
     (if (= count 0)
         b
         (fib-iter (+ a b) a (- count 1)))))
(define output-exp-let-combination
  '(begin
     (define (fib-iter a b count)
       (if (= count 0)
         b
         (fib-iter (+ a b) a (- count 1))))
     (fib-iter 1 0 7)))

(define named-let-test-exp
  '(begin
     (define (fib n)
       (let fib-iter ((a 1)
                      (b 0)
                      (count n))
         (if (= count 0)
             b
             (fib-iter (+ a b) a (- count 1)))))
     (fib 11)))
     
(display "[ex4.08 - Tests]\n")
(run (make-testcase
      '(assert-equal? #t (is-named-let? input-exp-let-combination))
      '(assert-equal? output-exp-let-combination (let->combination input-exp-let-combination))
      '(assert-equal? 89 (myeval named-let-test-exp tge))
      '(assert-equal? 5 (myeval '(let ((a 2) (b 3)) (+ a b)) tge))
      ))