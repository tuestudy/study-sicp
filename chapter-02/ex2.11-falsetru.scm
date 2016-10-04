(load "ex2.07-falsetru.scm")

(define (mul-interval2 x y) 
  (let ((n1 (lower-bound x))
        (n2 (upper-bound x))
        (n3 (lower-bound y))
        (n4 (upper-bound y)))
    (cond ((<= n2 0)
           ; - -
           ; - 0
           (cond ((<= n4 0) (make-interval (* n2 n4) (* n1 n3)))
                 ; - -
                 ; - 0
                 ((<= n3 0) (make-interval (* n1 n4) (* n1 n3)))
                 ; - +
                 ; 0 0
                 ; 0 +
                 (else      (make-interval (* n1 n4) (* n2 n3)))))
                 ; + +
          
          ((< n1 0)
           ; - +
           (cond ((<= n4 0) (make-interval (* n2 n3) (* n1 n3)))
                 ((<= n3 0) (make-interval (min (* n1 n4) (* n2 n3))
                                           (max (* n1 n3) (* n2 n4))))
                 (else      (make-interval (* n1 n4) (* n2 n4)))))
          (else
           ; 0 0
           ; 0 +
           ; + +
           (cond ((<= n4 0) (make-interval (* n2 n3) (* n1 n4)))
                 ((<= n3 0) (make-interval (* n2 n3) (* n2 n4)))
                 (else      (make-interval (* n1 n3) (* n2 n4))))))))
