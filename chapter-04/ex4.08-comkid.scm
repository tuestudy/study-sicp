;
; named-let form: (let <var> <bindings> <body>)
;
(define (named-let? exp) 
  (define op car)
  (define var cadr)
  (and (= (length exp) 4)
       (eq? (op exp) 'let)
       (not (list? (var exp)))))

(define (named-let->combination exp)
  (let ((var (cadr exp))
        (bindings (caddr exp))
        (body (cadddr exp)))
    (list 'begin
          (list 'define (cons var (map car bindings)) body)
          (cons var (map cadr bindings)))))
