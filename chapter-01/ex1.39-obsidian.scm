(load "../misc/scheme-test.scm")


(define (연속분수2 n d k)
  (define (iter count result)
    (if (= count 0)
       result
       (iter (- count 1) (/ (n count) (+ result (d count))))))
  (iter k 1.0))


(define (탄젠트 x i)
  (define (n-term i)
    (if (= i 1)
       x
       (- (* x x))))
  (define (d-term i)
    (- (* 2 i) 1))
  (연속분수2 n-term d-term i))


(run (make-testcase 
      '(assert-near? 
        1.00000001
        1.0000
        0.1)
      '(assert-near? 
        1.61803398874989484820458683436563811
        (/ 1 (연속분수2 (lambda(x) 1.0) (lambda(x) 1.0) 12))
        0.001)
      '(assert-near? 
        (tan 0.9)
        (탄젠트 0.9 10)
        0.001)
      ))