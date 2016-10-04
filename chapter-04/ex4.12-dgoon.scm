(load "ex4.11-dgoon.scm")

(define (scan-frame var frame)
  (let ((vars (frame-variables frame))
	(vals (frame-values frame)))
    (define (iter _vars _vals)
      (cond ((null? _vars) '())
	    ((eq? var (car _vars))
	     (make-frame _vars _vals))
	    (else
	     (iter (cdr _vars) (cdr _vals)))))
    (iter vars vals)))

(define (scan-env var env)
  (if (eq? env the-empty-environment)
      (error "Unbound variable")
      (let ((frame (first-frame env)))
	(let ((temp-frame (scan-frame var frame)))
	  (if (null? temp-frame)
	      (scan-env var
			(enclosing-environment env))
	      temp-frame)))))

(define (lookup-variable-value var env)
  (let ((temp-frame (scan-env var env)))
    (car (frame-values temp-frame))))

(define (set-variable-value! var val env)
  (let ((temp-frame (scan-env var env)))
    (let ((vals (frame-values temp-frame)))
      (set-car! vals val))))

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (let ((temp-frame (scan-frame var frame)))
      (if (null? temp-frame)
	  (add-binding-to-frame! var
				 val
				 frame)
	  (let ((vals (frame-values temp-frame)))
	    (set-car! vals val))))))
 