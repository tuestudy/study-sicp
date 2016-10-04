(load "ex4.06-dgoon.scm")

(define (make-one-arg-let arg val body)
  ;(display arg)(display " / ")(display val)(newline)
  (if (null? arg)
      (car body)
      (append (list 'let (list (list arg val)))
	      body)))

(define (let*->nested-lets exp)
  (define (nested-lets args vals body)
    (if (null? args)
	body
	(make-one-arg-let (car args)
			  (car vals)
			  (if (null? (cdr args))
			      body
			      (list (nested-lets (cdr args)
						 (cdr vals)
						 body))))))
  (let ((exps (let-exps exp))
	(body (let-body exp)))
    (let ((vars (let-vars exps))
	  (vals (let-vals exps)))
      #|
      (display "VARS:")(display vars)(newline)
      (display "VALS:")(display vals)(newline)
      (display "BODY:")(display body)(newline)
      |#
      (nested-lets vars vals body))))

(define (install-let*)
  (put 'myeval 'let* (lambda (exp env)
		       (myeval (let*->nested-lets exp)
			       env))))
(install-let*)