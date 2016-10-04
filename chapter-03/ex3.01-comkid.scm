(load "../misc/scheme-test-r5rs.scm")

(define (make-accumulator x)
  (let ((acc x))
    (lambda (n) 
      (begin (set! acc (+ acc n))
             acc)))) 

(define A (make-accumulator 5))

(run (make-testcase
      '(assert-equal? 15 (A 10))
      '(assert-equal? 25 (A 10))
      ))
