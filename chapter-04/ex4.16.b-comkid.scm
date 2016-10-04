(define (scan-out-defines body)
  (define (make-unassigned-variable var)
    (list (list var ''*unassigned*)))
  
  (define (make-unassigned-procedure var)
    (list (list (car var) ''*unassigned*)))
  
  (define (make-set-variable var value)
    (list (list 'set! var (car value))))
  
  (define (make-set-procedure var value)
    (list (list 'set! (car var) (make-lambda (cdr var) value))))  
  
  (define (merge body decs defines)
    (if (null? decs)
        body
        (list (append (list 'let decs) defines body))))
  
  (let ((decs '())
        (defs '()))
    
    (define (parse-internal-definition exp)
      (let ((head (cadr exp))
            (rest (cddr exp)))
        (if (list? head)
            (begin
              (set! decs (append decs (make-unassigned-procedure head)))
              (set! defs (append defs (make-set-procedure head rest))))
            (begin
              (set! decs (append decs (make-unassigned-variable head)))
              (set! defs (append defs (make-set-variable head rest)))))))
    
    (define (scan-body exps)
      (if (definition? (car exps))
          (begin
            (parse-internal-definition (car exps))
            (scan-body (cdr exps)))
          exps))
    
    (merge (scan-body body) decs defs)))