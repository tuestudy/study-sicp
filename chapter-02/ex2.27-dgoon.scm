(load "../misc/scheme-test.scm")

(define (reverse seq)
  (if (null? seq)
      '()
      (append (reverse (cdr seq)) (list (car seq)))))

(define (deep-reverse tree)
  (if (pair? tree)
      (reverse (map deep-reverse tree))
      tree))

(define base-list '(1 2 3 4 5))
(define test-list '(1 (2 3) (4 (5 6 7) 8 9) 10))

(run
  (make-testcase
    '(assert-equal? '(5 4 3 2 1)
                    (reverse base-list))
    '(assert-equal? (reverse base-list)
                    (deep-reverse base-list))
    '(assert-equal? '(10 (4 (5 6 7) 8 9) (2 3) 1)
                    (reverse test-list))
    '(assert-equal? '(10 (9 8 (7 6 5) 4) (3 2) 1)
                    (deep-reverse test-list))))
