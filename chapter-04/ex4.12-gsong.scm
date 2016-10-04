(define (find-var-action env var foundProc notInFrameProc)
  (define (scan frame)
    (cond
      ((null? frame)
       (if (null? notInFrameProc)
           (find-var-action (enclosing-environment env) var foundProc notInFrameProc)
           (notInFrameProc)))
      ((eq? var (car (first-pair frame)))(foundProc frame))
      (else (scan (cdr frame)))))
  
    (if (eq? env the-empty-environment)
        (error "Unbound variable " var)
        (let ((frame (first-frame env)))
          (scan frame))))
  
; lookup-variable-value
(define (lookup-variable-value var env)
  (find-var-action env var (lambda (frame) (cadr (first-pair frame))) '()))

(define (define-variable! var val env)
  (find-var-action env var
                   (lambda (frame) (set-cdr! (first-pair frame) (list val)))
                   (lambda () (add-binding-to-frame! var val (first-frame env)))))
  
; set-variable-value!
(define (set-variable-value! var val env)
  (find-var-action env var (lambda (frame) (set-cdr! (first-pair frame) (list val))) '()))
