(require test/scheme-test)

(define (map2 proc item)
  (if (null? item)
      nil
      (cons (proc (car item)) (map2 proc (cdr item)))))

(define (square-list item)
  (map (lambda(x)(* x x)) item))

(define (square-list2 item)
  (if (null? item)
  nil
  (cons ((lambda(x) (* x x)) (car item)) (square-list (cdr item)))))

(run (make-testcase
      '(assert-equal? (+ 1 1) 2)))
  