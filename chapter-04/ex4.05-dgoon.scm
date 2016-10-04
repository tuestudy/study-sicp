(load "../chapter-04/ex4.04-dgoon-again.scm")
;(load "../chapter-04/ex4.04-dgoon_yarra.scm")

(define test-environment (setup-environment))

;; expand "(a => b)" to "(a (b a))"
(define (cond-actions clause)
  (if (equal? (cadr clause) '=>)
      (list (cond-predicate clause)
            (list (caddr clause)
                  (cond-predicate clause)))
      (cdr clause)))
