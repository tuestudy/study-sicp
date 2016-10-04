(load "ex2.40-falsetru.scm")

(define (sum-triples n s)
  (filter (lambda (xs) (= (foldr + 0 xs) s))
          (unique-triples n)))

(define (unique-triples n)
  (flatmap (lambda (k)
             (flatmap (lambda (j)
                        (map (lambda (i) (list i j k))
                             (enumerate-interval 1 (- j 1))))
                      (enumerate-interval 1 (- k 1))))
           (enumerate-interval 1 n)))
