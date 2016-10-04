(load "scheme-test-r5rs.scm")

(define (seq start end)
  (define (iter start end result)
    (if (> start end)
        result
        (iter start (- end 1) (cons end result))))
  (iter start end '()))

(define seq-test 
  (make-testcase
   '(assert-true? (equal? (list 1 2 3 4) (seq 1 4)))
   '(assert-equal? (list 1 2 3 4) (seq 1 4))))

(run seq-test)
(run 
 (make-testcase
  '(assert-true? (equal? (list 1 2 3 4) (seq 1 4)))
  '(assert-false? (equal? (list 1 2 3 4) (seq 1 2)))
  '(assert-equal? (list 1 2 3 4) (seq 1 4))
  '(assert-near? 0.1231 0.1234 0.001)
  '(assert-near? 0.123456789 0.123456780 0.00000001)))

(run-named-test "seq-test" seq-test)
