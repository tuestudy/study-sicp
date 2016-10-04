(load "../misc/scheme-test.scm")

(define (product term a next b)
  (define (iter start result)
    (if (> start b)
        result
        (iter (next start) (* result (term start)))))
  (iter a 1))

(define (factorial n)
  (product (lambda (x) x)
           1
           (lambda (x) (+ x 1))
           n))

(define (get-pi) 
  (define (term n)
    (if (even? n)
        (/ (+ n 2.0) (+ n 1.0))
        (/ (+ n 1.0) (+ n 2.0))))
  (* 4 
     (product term 
              1
              (lambda (x) (+ x 1))
              1000000)))
(define (square x) (* x x))
(define (inc-2 x) (+ x 2))

(run (make-testcase 
      '(assert-near? pi (get-pi) 0.00001)
      '(assert-near? pi (get-pi) -0.00001)
      '(assert-equal? (* 1 2 3 4 5) (factorial 5))))

