(load "../misc/scheme-test.scm")
(load "../misc/accumulate.scm")

(define (count-leaves t)
  (accumulate +
              0
              (map
               (lambda (x)
                 (cond ((null? x) 0)
                       ((pair? x) (count-leaves x))
                       (else 1)))
               t)))

(run
 (make-testcase
  '(assert-equal? 1 (count-leaves (list 1)))
  '(assert-equal? 3 (count-leaves (list (list 1 2) 4)))))