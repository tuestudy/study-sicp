(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))

(define ex2.55-falsetru-tests
  (test-suite
   "Test for ex2.55-falsetru"

   (check-equal? (car ''abracadabra) 'quote)
   (check-equal? ''abracadabra '(quote abracadabra))
   (check-equal? '(quote abracadabra) (list 'quote 'abracadabra))
   (check-equal? (car (list 'quote 'abracadabra)) 'quote)

   (check-equal? ''abracadabra (quote 'abracadabra))
   (check-equal? '(quote abracadabra) (quote (quote abracadabra)))
   ))

(exit
  (cond
    ((= (run-tests ex2.55-falsetru-tests) 0))
    (else 1)))
