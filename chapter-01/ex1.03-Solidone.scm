(define (square x) (* x x))

(define (sum-of-squares x y) (+ (square x) (square y)))

(define (middle x y z) (-(+ x y z) (max x y z) (min x y z))) 

(define (two-big-squares x y z) (sum-of-squares (max x y z) (middle x y z)))

(two-big-squares 1 2 3)

(two-big-squares 3 2 3)

(two-big-squares 10 2 3)


