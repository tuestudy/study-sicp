(load "ex2.63-falsetru.scm")

(define (key x) x)
(define (lookup given-key tree)
  (cond ((null? tree) false)
        ((equal? given-key (key (entry tree)))
         (entry tree))
        ((< given-key (key (entry tree)))
         (lookup given-key (left-branch tree)))
        ((> given-key (key (entry tree)))
         (lookup given-key (right-branch tree)))))
