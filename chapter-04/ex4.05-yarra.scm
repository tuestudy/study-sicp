(load "ch4-myeval-pkg-yarra.scm")
(load "../misc/scheme-test-r5rs.scm")

;answer

(define (eval-cond exp env)
  (define (cond-clauses exp) (cdr exp))
  (define (eval-clauses clauses env)
    (define (eval-actions clause)
      (let ((pred (car clause))
            (value (cdr clause)))
        (if (eq? (car value) '=>)
            (myeval (list (cadr rest) test) env)
            (myeval (sequence->exp rest) env))))
    (let ((clause (car clauses)))
      (if (cond-else-clause? clause)
          (myeval (sequence->exp (cond-actions clause)) env)
          (if (true? (myeval (cond-predicate clause) env))
              (eval-actions clause)
              (eval-clauses (cdr clauses) env)))))
  (eval-clauses (cond-clauses exp) env))


;test
(define the-global-environment (setup-environment))

(run (make-testcase
      '(assert-equal? 1 (myeval '(cond2 ('(1 2 3 4) => car)) the-global-environment))))