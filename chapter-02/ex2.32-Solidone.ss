(define a 
  (lambda (x)
    (if (pair? x)
        (cadr x)
        list)))

(define (subsets s)
  (define a
    (lambda (x)
      (list x)))
  (if (null? s)
      (list null)
      (let ((rest (subsets (cdr s))))
        (append rest (map a rest)))))


(subsets (list 1 2 3))
(list (list) (list 3) (list 2) (list 2 3) (list 1) (list 1 3) (list 1 2) (list 1 2 3))