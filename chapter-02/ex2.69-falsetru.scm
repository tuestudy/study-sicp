(load "ex2.68-falsetru.scm")

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge set)
  (if (= (length set) 1)
    (car set)
    (successive-merge
      (adjoin-set
        (make-code-tree
          (car set)
          (cadr set))
        (cddr set)))))
