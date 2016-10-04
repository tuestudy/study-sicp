(load "ex4.12-dgoon.scm")

(define (install-make-unbound!)
  (put 'myeval 'make-unbound!
       (lambda (exp env)
	 (make-unbound! (cadr exp) env))))

(install-make-unbound!)

(define (filter pred seq)
  (cond ((null? seq) '())
	((pred (car seq))
	 (cons (car seq)
	       (filter pred (cdr seq))))
	(else
	 (filter pred (cdr seq)))))

(define (make-new-frame-without var frame)
  (let ((vars (frame-variables frame))
	(vals (frame-values frame)))
    (let ((vars-vals (filter (lambda (x) (not (eq? var (car x))))
			     (map cons vars vals))))
      (let ((new-frame (make-frame (map car vars-vals)
				   (map cdr vars-vals))))
	new-frame))))

(define (install-make-unbound!)
  (put 'myeval 'make-unbound! (lambda (exp env)
				(set-car! env
					  (make-new-frame-without (cadr exp)
								  (car env))))))

(install-make-unbound!)

