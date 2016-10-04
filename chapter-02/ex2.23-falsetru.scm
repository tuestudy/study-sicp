(define (for-each2 f xs)
  (cond ((not (null? xs))
         (f (car xs))
         (for-each2 f (cdr xs)))))
