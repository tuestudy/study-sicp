; 3.27


; 테이블 정의
(define (lookup key table)
  (let ((record (assoc key (cdr table))))
    (if record
        (cdr record)
        #f)))

(define (assoc2 key records)
  (cond ((null? records) #f)
        ((equal? key (caar records)) (car records))
        (else (assoc2 key (cdr records)))))

(define (insert! key value table)
  (let ((record (assoc key (cdr table))))
    (if record
        (set-cdr! record value)
        (set-cdr! table
                  (cons (cons key value) (cdr table)))))
  'ok)


; 그냥 피보나치
(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

; 치팅하는 피보나치.
(define fib2
  ((lambda (tbl)
     (lambda (x)
       (cond ((= x 0) 0)
             ((= x 1) 1)
             (else (let ((cheat (lookup x tbl)))
                     (if cheat
                         cheat
                         (let ((answer (+ (fib2 (- x 1))
                                          (fib2 (- x 2)))))
                           (begin (insert! x answer tbl) answer)))))))) (list '*table*)))