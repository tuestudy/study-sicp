(load "ex2.07-falsetru.scm")

(define (width x)
  (/ (- (upper-bound x)
        (lower-bound x))
     2.0))
