(define (eval-make-unbound! exp env)
  (let ((var (cadr exp)))
    (let ((frame (scan-frame var (car env))))
      (cond ((null? frame) 'fail)
            ((null? (cdr frame)) (remove-head-from-list env))
            (else 
             (remove-head-from-list frame))))))

(define (remove-head-from-list L)
  (let ((first (cadr L))
        (rest (cddr L)))
    (set-car! L first)
    (set-cdr! L rest)
    'ok))

