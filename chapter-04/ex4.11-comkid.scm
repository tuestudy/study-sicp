(define (make-frame variables values)
  (map cons variables values))

(define (frame-variables frame)
  (map car frame))

(define (frame-values frame) 
  (map cdr frame))

(define (add-binding-to-frame! var val frame)
  (let ((first (car frame))
        (rest (cdr frame))
        (new (cons var val)))
      (set-cdr! frame (cons first rest))
      (set-car! frame new)))

