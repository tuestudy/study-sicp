(define (deep-reverse xs)
  (if (pair? xs)
    (reverse (map deep-reverse xs))
    xs))
