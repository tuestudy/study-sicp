(load "../misc/scheme-test.scm")

(define (for-each2 proc item)
  (cond [(not (null? item)) 
         (and (proc (car item)) (for-each2 proc (cdr item)))]))

(for-each2 (λ(x) (newline) (display x)) '(57 321 88))

(run (make-testcase
      '(assert-equal? (+ 1 1) 2)))