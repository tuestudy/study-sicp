(load "../misc/scheme-test-r5rs.scm")

(define (make-visit-nodes lists)
  (define (add-node x) 
    (set! lists (cons x lists)))
  (define (visit? x) 
    (define (iter x nodes)
      (cond ((null? nodes) #f)
            ((eqv? x (car nodes)) #t)
            (else (iter x (cdr nodes)))))
    (iter x lists))
  (define dispatch
    (lambda (proc x) 
      (cond ((equal? 'add-node proc) (add-node x))
            ((equal? 'visit? proc) (visit? x))
            (else (display "undefined")))))
  dispatch)

(define (count-pairs x)
  (let ((visit-nodes (make-visit-nodes '())))
    (define (count nodes)
      (cond ((not (pair? nodes)) 0)
            ((visit-nodes 'visit? nodes) 0)
            (else
             (begin 
               (visit-nodes 'add-node nodes)
               (+ (count (car nodes))
                  (count (cdr nodes))
                  1)))))
    (count x)))

(define a (cons 1 2))
(define b (cons 3 4))
(define c (cons a a))

(define x1 (cons 1 (cons 2 a)))
(define x2 (cons b a))
(define y1 (cons 1 (cons a a)))
(define y2 (cons a (cons 1 a)))
(define z3 (cons c c))

(define a1 (cons 1 2))
(define b1 (cons 1 a1))
(set-cdr! a1 b1)
(define c1 (cons 1 b1))

(run (make-testcase  
      '(assert-equal? 3 (count-pairs x1))
      '(assert-equal? 3 (count-pairs x2))      
      '(assert-equal? 3 (count-pairs y1))      
      '(assert-equal? 3 (count-pairs y2)) 
      '(assert-equal? 3 (count-pairs z3)) 
      '(assert-equal? 3 (count-pairs c1)) 
      ))
