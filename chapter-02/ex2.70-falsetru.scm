(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.69-falsetru.scm")

(define ex2.70-falsetru-tests
  (test-suite
    "Test for ex2.70-falsetru"

    (test-case
      "encode"
      (define t (generate-huffman-tree '((A 2)
                                         (BOOM 1)
                                         (GET 2)
                                         (JOB 2)
                                         (NA 16)
                                         (SHA 3)
                                         (YIP 9)
                                         (WAH 1))))
      (define lyrics '(GET A JOB
                           SHA NA NA NA NA NA NA NA NA
                           GET A JOB
                           SHA NA NA NA NA NA NA NA NA
                           WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP
                           SHA BOOM))
      (check-equal? (length (encode lyrics t)) 84)
      (check-equal? (* (length lyrics) 3) 108)
      ; 3 <- (ceiling (/ (log 8) (log 2)))
      ; 8 <- 8 words.
      )))

(exit
  (cond
    ((= (run-tests ex2.70-falsetru-tests) 0))
    (else 1)))
