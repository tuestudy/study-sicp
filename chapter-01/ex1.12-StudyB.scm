(define (seq start end)
  (define (iter cur result)
    (if (> cur end)
        result
        (iter (+ cur 1) (append result (list cur)))))
  (iter start null))

(equal? (list 1 2 3 4 5) (seq 1 5))


(define (pascal-triangle nth-row-proc n)
  (map nth-row-proc (seq 1 n)))

(define (nth-row n)
  (if (= n 1)
      (list 1)
      (f (append (cons 0 (nth-row (- n 1))) (list 0)))))

(define (nth-row-iter n)
  (define (iter i result)
    (if (= i n)
        result
        (iter (+ i 1) (f-iter (append (cons 0 result) (list 0))))))
  (iter 1 (list 1)))

(define (f x)
  (if (< (length x) 2)
      null
      (cons (+ (car x) (cadr x)) (f (cdr x)))))

(define (f-iter x)
  (define (iter input result)
    (if (null? (cdr input)) 
        result
        (iter (cdr input) 
              (append result (list (+ (car input) (cadr input)))))))
  (iter x null))

(equal?  (list 1 4 6 4 1) (f (list 0 1 3 3 1 0)))
(equal? (list (list 1) (list 1 1)) (pascal-triangle nth-row 2)) 

(equal? (list 1) (nth-row 1)) 
(equal? (list 1 1) (nth-row 2))
(equal? (list 1 2 1) (nth-row 3))

(display "iter test\n")
(equal?  (list 1 4 6 4 1) (f-iter (list 0 1 3 3 1 0)))
(equal? (list 1) (nth-row-iter 1)) 
(equal? (list 1 1) (nth-row-iter 2))
(equal? (list 1 2 1) (nth-row-iter 3))
(equal? (list (list 1) (list 1 1)) (pascal-triangle nth-row-iter 2)) 

(map (lambda (x) (display x) (newline) #t) (pascal-triangle nth-row-iter 3))
(map (lambda (x) (display x) (newline) #t) (pascal-triangle nth-row-iter 10))
