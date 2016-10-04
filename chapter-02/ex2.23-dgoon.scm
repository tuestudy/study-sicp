(load "../misc/scheme-test.scm")

(define (for-each proc items)
  (if (null? items)
      '()
      (or (and (proc (car items)) #f)
          (for-each proc (cdr items)))))

(for-each (lambda (x) (newline) (display x))
          (list 57 321 88))

(newline)

