(define (show-unbound-variable-error var)
  (display "[Error] Unbound variable: ") 
  (display var)
  (newline))

(define (scan-frame var frame)
  (cond ((null? frame) frame)
        ((eq? var (car (car frame))) frame)
        (else (scan-frame var (cdr frame)))))

(define (scan var env)
  (if (eq? env the-empty-environment)
      '()
      (let ((frame (scan-frame var (first-frame env))))
        (if (null? frame)
            (scan var (enclosing-environment env))
            frame))))

(define (set-variable-value! var val env)
  (let ((frame (scan var env)))
    (if (null? frame)
        (show-unbound-variable-error var)
        (set-cdr! (car frame) val))))

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (let ((f (scan-frame var frame)))
      (if (null? f)
          (add-binding-to-frame! var val frame)
          (set-cdr! (car f) val)))))

(define (lookup-variable-value var env)
  (let ((frame (scan var env)))
    (if (null? frame)
        (show-unbound-variable-error var)
        (cdr (car frame)))))