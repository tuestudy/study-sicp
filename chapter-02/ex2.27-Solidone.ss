(define x (list (list 1 2) (list 3 4)))

; from ex2.18.
(define (reverse1 items)
  (define (iter item result)
    (if (null? item)
        result
        (iter (cdr item) (cons (car item) result))))
  (iter items null))

; solve
(define (deep-reverse x)
  (reverse1 (map reverse-if-pair x)))

(define (reverse-if-pair x)
  (if (pair? x)
      (reverse1 x)
      x))

; test
(equal? (list (list 3 4) (list 1 2)) (reverse1 x))
(equal? (list (list 4 3) (list 2 1)) (deep-reverse x))


