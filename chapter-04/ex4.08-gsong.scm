(define (is-named-let? exp)
  (if (null? (cdddr exp)) #f #t))
(define (let->combination exp)
  (if (is-named-let? exp)
      ; named let
      (let ((name (cadr exp))
            (vars (map car (caddr exp)))
            (body (cadddr exp))
            (initvals (map cadr (caddr exp))))
        (make-begin (cons (make-define (cons name vars) body) (list (cons name initvals)))))
      
            ; ordinal let
      (let ((vars (cadr exp))
            (body (cddr exp)))
        (cons (make-lambda (map car vars) body)
              (map cadr vars)))))

        