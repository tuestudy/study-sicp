(load "../misc/scheme-test.scm")

(define m '((1 2 3 4) (4 5 6 6) (6 7 8 9)))
(define n '((1 2 3) (4 5 6) (7 8 9)))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      null
      (cons (foldr op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

(define (dot-product v w)
  (foldr + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (λ (x) (dot-product x v)) m))

(define (transpose m)
  (accumulate-n cons null m))

(define (matrix-*-matrix m w)
  (let ([multi (transpose w)])
    (map (λ (x)
           (map (λ (y) (dot-product x y))
                multi))
           m)))
           


(run (make-testcase
      '(assert-equal? (+ 1 1) 2)
      '(assert-equal? (dot-product '(1 2 3 4) '(1 2 3 4)) 30)
      '(assert-equal? (matrix-*-vector m '(1 2 3 4)) '(30 56 80))
      '(assert-equal? (transpose m) '((1 4 6) (2 5 7) (3 6 8) (4 6 9)))
      '(assert-equal? (matrix-*-matrix n n) '((30 36 42) (66 81 96) (102 126 150)))
      '(assert-equal? (matrix-*-matrix '((1 2 3 4) (5 6 7 8)) '((1 5) (2 6) (3 7) (4 8))) 
                      '((30 70) (70 174)))
      ))
