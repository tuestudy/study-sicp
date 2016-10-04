(define (let*->nested-lets exp)
  (let ((vars (cadr exp))
        (body (caddr exp)))
    (expend-nested-lets vars body))) 

(define (expend-nested-lets vars body)
  (if (null? vars) 
      body
      (list 'let (list (car vars)) (expend-nested-lets (cdr vars) body))))
