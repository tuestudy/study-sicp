; 2.39

(load "../misc/scheme-test.scm")

(define (fold-right op initial sequence)   
  (if (null? sequence)       
      initial       
      (op (car sequence)           
          (fold-right op initial (cdr sequence)))))   


(define (fold-left op initial sequence)        
  (define (iter result rest)
    (if (null? rest)         
        result        
        (iter (op result (car rest))     
              (cdr rest))))       
  (iter initial sequence)) 


; solution
(define (reverse2 l)
  (fold-right (lambda (x y) (append y (list x))) '() l))
(define (reverse3 l)
  (fold-left (lambda (x y) (cons y x)) '() l))

; test
(define l1 (list 1 2 3 4))

(run
 (make-testcase
  '(assert-equal? '(4 3 2 1) (reverse2 l1))
  '(assert-equal? '(4 3 2 1) (reverse3 l1))))

