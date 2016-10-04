(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.69-falsetru.scm")

(define ex2.71-falsetru-tests
  (test-suite
    "Test for ex2.71-falsetru"

    (test-case
      "n=5"
      (define t (generate-huffman-tree '((a 1)
                                         (b 2)
                                         (c 4)
                                         (d 8)
                                         (e 16))))
      (check-equal? (length (encode-symbol 'a t)) 4)
      (check-equal? (length (encode-symbol 'e t)) 1))
    (test-case
      "n=10"
      (define t (generate-huffman-tree '((a 1)
                                         (b 2)
                                         (c 4)
                                         (d 8)
                                         (e 16)
                                         (f 32)
                                         (g 64)
                                         (h 128)
                                         (i 256)
                                         (j 512))))
      (check-equal? (length (encode-symbol 'a t)) 9)
      (check-equal? (length (encode-symbol 'j t)) 1))
    ))

(exit
  (cond
    ((= (run-tests ex2.71-falsetru-tests) 0))
    (else 1)))
