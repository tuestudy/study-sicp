(load "../misc/scheme-test.scm")

(define (product term a next b)
  (define (iter start result)
    (if (> start b)
        result
        (iter (next start) (* result (term start)))))
  (iter a 1))

(define (sum term a next b)
  (define (iter start result)
    (if (> start b)
        result
        (iter (next start) (+ result (term start)))))
  (iter a 0))

(define (accumulate combiner null-value term a next b)
  (define (iter start result)
    (if (> start b)
        result
        (iter (next start) (combiner result (term start)))))
  (iter a null-value))

(define (seq start end)
  (accumulate append
              null
              (lambda (x) (list x))
              start
              (inc-n 1)
              end))

(define (seq2 start end)
  (accumulate (lambda (result elem) (cons elem result))
              null
              (lambda (x) (- end x))
              0
              (inc-n 1)
              (- end start)))

(define (factorial n)
  (product (lambda (x) x)
           1
           (lambda (x) (+ x 1))
           n))

(define (factorial-acc n)
  (product-acc (lambda (x) x)
               1
               (lambda (x) (+ x 1))
               n))


(define (inc-n n) 
  (lambda (x) (+ x n)))

(define (self x) x)


(define (sum-acc term a next b)
  (accumulate + 0 term a next b))

(define (product-acc term a next b)
  (accumulate * 1 term a next b))

(define accumulate-test
  (make-testcase 
   '(assert-equal? (+ 1 2 3 4 5) (sum self 1 (inc-n 1) 5))      
   '(assert-equal? (* 1 2 3 4 5) (factorial 5))
   '(assert-equal? (sum self 1 (inc-n 1) 5)
                   (sum-acc self 1 (inc-n 1) 5))      
   '(assert-equal? (factorial 5) (factorial-acc 5))
   '(assert-equal? (list 1 2 3 4 5) (seq 1 5))
   '(assert-equal? (list 1 2 3 4 5) (seq2 1 5))))

(run accumulate-test)

