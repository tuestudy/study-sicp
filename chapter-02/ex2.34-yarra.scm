; 2.34

; 아래와 같이 정의된 x의 다항식 값 계산 과정을 accumulate로 나타내 보자.

(load "../misc/accumulate.scm")
(load "../misc/scheme-test.scm")



(define (horner-eval x coeff-seq)
  (accumulate (lambda (this-coeff higher-terms) (+ this-coeff (* x higher-terms)))
              0
              coeff-seq))


(run
 (make-testcase
  '(assert-equal? 79 (horner-eval 2 (list 1 3 0 5 0 1)))))

