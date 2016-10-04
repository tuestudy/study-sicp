(define (square x)(* x x))

(define (3min a b c)(min (min a b) c))

(define (ex1.3 a b c)
  (- (+ (square a)(square b)(square c))(square (3min a b c)))
  )

(ex1.3 2 3 4)
  


