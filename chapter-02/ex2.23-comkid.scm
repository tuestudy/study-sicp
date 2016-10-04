(define (for-each1 proc items)
  (if (not (null? items))
      (and (proc (car items)) (for-each1 proc (cdr items)))))

(define (for-each2 proc items)
  (cond ((not (null? items))
         (proc (car items)) 
         (for-each2 proc (cdr items)))))

(for-each1 (lambda (x) (newline) (display x))
          (list 57 321 88))

(for-each1 (lambda (x) (newline) (display x)) null)

(for-each2 (lambda (x) (newline) (display x))
          (list 57 321 88))

(for-each2 (lambda (x) (newline) (display x)) null)