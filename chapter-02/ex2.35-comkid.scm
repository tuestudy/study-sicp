(load "../misc/scheme-test.scm")
(load "../misc/accumulate.scm")

(define (count-leaves-original x)
  (cond ((null? x) 0)  
        ((not (pair? x)) 1)
        (else (+ (count-leaves-original (car x))
                 (count-leaves-original (cdr x))))))

(define (count-leaves t)
  (accumulate (lambda (x y) (+ x y)) 
              0 
              (map (lambda (x) (if (pair? x) (count-leaves x) 1)) 
                   t)))

; Test
(define x (list 1 (list 2 (list 3 4))))

(run (make-testcase
      '(assert-equal? 4 (count-leaves-original x))
      '(assert-equal? (count-leaves-original x) (count-leaves x))
      ))