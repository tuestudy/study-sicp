(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))

(define ex2.53-falsetru-tests
  (test-suite
   "Test for ex2.53-falsetru"

   (check-equal? (list 'a 'b 'c) '(a b c))
   (check-equal? (list (list 'george)) '((george)))
   (check-equal? (cdr '((x1 x2) (y1 y2))) '((y1 y2)))
   (check-equal? (cadr '((x1 x2) (y1 y2))) '(y1 y2))
   (check-false (pair? (car '(a short list))))
   (check-equal? (memq 'red '((red shoes) (blue socks))) false)
   (check-equal? (memq 'red '(red shoes blue socks)) '(red shoes blue socks))
   ))

(exit
  (cond
    ((= (run-tests ex2.53-falsetru-tests) 0))
    (else 1)))
