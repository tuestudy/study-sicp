(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (fringe x)
  (cond ((null? x) null)  
        ((not (pair? x)) (list x))
        (else (append (fringe (car x))
                      (fringe (cdr x))))))

(define (count-leaves t)
  (accumulate +
              0
              (map
               (lambda (x)
                 (cond ((null? x) 0)
                       ((not (pair? x)) 1))) 
               (fringe t))))


(define (count-leaves2 x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))

(define a (list (list 1 2) (list 3 4)))

; test-case
(= (count-leaves a)
   (count-leaves2 a))
(= 10
   (count-leaves (list 1 2 (list 1 (list 3 4) (list 7 9 10)) (list 100 1))))



