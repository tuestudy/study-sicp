(define (fringe xs)
  (cond ((null? xs) xs)
        ((not (pair? xs)) (list xs))
        (else (append (fringe (car xs)) (fringe (cdr xs))))))
