(define (remove-first-from-list list)
  (cond
    ((null? list) #f)
    ((null? (cdr list)) (set! list '()) #t)
    (else
     (begin
       (set-car! list (cadr list))
       (set-cdr! list (cddr list))
       #t))))
    
(define (remove-binding-from-frame! var frame)
  (cond
    ((null? frame) #f)
    ((eq? var (car (first-pair frame))) (remove-first-from-list frame))
    (else (remove-binding-from-frame! var (cdr frame)))))
      

(define (undefine! var env)
  (find-var-action env var
                   (lambda (frame) (remove-binding-from-frame! var frame))
                   '()))

(define (make-unbound! var env)
  (list 'undefine var env))

(define (eval-undefine exp env)
  (undefine! (cadr exp) env))

(put 'undefine 'eval eval-undefine)