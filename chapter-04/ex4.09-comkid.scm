(define (while->named-let exp)
  (let ((init (cadr exp))
        (pred (caddr exp))
        (body (cadddr exp)))
    (list 'let
          'iter
          init
          (list 'if (list pred (car (cadr init)))
                (cons 'iter body)
                (car (car init))))))
