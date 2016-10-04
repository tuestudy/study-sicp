; TODO: There's a bug in my solution
(define (setup-environment)
  (let ((initial-env
         (extend-environment2 (make-pair (primitive-procedure-names) (primitive-procedure-objects)) the-empty-environment)))
    (define-variable! 'true true initial-env)
    (define-variable! 'false false initial-env)
    initial-env))

(define primitive-procedure-pairs
 '())
(define (make-pair list1 list2)
  (if (null? list1) '()
      (cons (list (car list1) (car list2)) (make-pair (cdr list1) (cdr list2)))))
  
(define (first-pair frame)
  (car frame))

(define (error msg var)
  (begin (display msg) (display var) (display "\n") '()))

; lookup-variable-value
(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan frame)
      (cond
        ((null? frame) (env-loop (enclosing-environment env)))
        ((eq? var (car (first-pair frame))) (cadr (first-pair frame)))
        (else (scan (cdr frame)))))
    
    (if (eq? env the-empty-environment)
        (error "Unbound variable " var)
        (let ((frame (first-frame env)))
          (scan frame))))
  
  (env-loop env))

; extend-environment
(define (make-frame variables values)
  (if (or (null? variables) (null? values)) '()
      (cons (list (car variables) (car values))
            (make-frame (cdr variables) (cdr values)))))
(define (extend-environment vars vals base-env)
  (extend-environment2 (make-frame vars vals) base-env))
;
(define (extend-environment2 frame base-env)
  (cons frame base-env))

; define-variable!
(define (add-binding-to-frame! var val frame)
  (let
      ((temp (cons (car frame) (cdr frame))))
  (begin
    (set-car! frame (list var val))
    (set-cdr! frame temp))))

(define (define-variable! var val env)
  (define (scan frame)
    (cond
      ((null? frame) (add-binding-to-frame! var val (first-frame env)))
      ((eq? var (car (first-pair frame))) (set-cdr! (first-pair frame) (list val)))
      (else (scan (cdr frame)))))
  (scan (first-frame env)))
  
; set-variable-value!
(define (set-variable-value! var val env)
  (define (env-loop env)
    (define (scan frame)
      (cond
        ((null? frame) (env-loop (enclosing-environment env)))
        ((eq? var (car (first-pair frame))) (set-cdr! (first-pair frame) (list val)))
        (else (scan (cdr frame)))))
    
    (if (eq? env the-empty-environment)
        (error "Unbound variable -- SET!" var)
        (let ((frame (first-frame env)))
          (scan frame))))
    
  (env-loop env))

(define (frame-variables frame)
  (map car frame))
(define (frame-values frame)
  (map cadr frame))