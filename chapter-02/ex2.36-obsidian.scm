(load "../misc/scheme-test.scm")

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      null
      (cons (foldr op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))


(run (make-testcase
      '(assert-equal? (+ 1 1) 2)
      '(assert-equal? (accumulate-n + 0 '((1 2 3) (4 5 6) (7 8 9) (10 11 12))) '(22 26 30))
      ))
