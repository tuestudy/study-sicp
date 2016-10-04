(load "../misc/scheme-test.scm") 

(define (map2 p sequence)
  (foldr (lambda (x y) 
           (cons (p x) y)) 
         null sequence))

(define (append2 seq1 seq2)
  (foldr cons
         seq2 
         seq1))

(define (length2 sequence)
  (foldr (λ (x y) (+ 1 y))
         0
         sequence))


(run (make-testcase
      '(assert-equal? (+ 1 1) 2)
      '(assert-equal? (map2 (λ(x)(* x x)) '(1 2 3 4)) '(1 4 9 16))
      '(assert-equal? (append2 '(1 2 3 4) '(5 6 7 8)) '(1 2 3 4 5 6 7 8))
      '(assert-equal? (length2 '(1 2 3 4)) 4)
      ))