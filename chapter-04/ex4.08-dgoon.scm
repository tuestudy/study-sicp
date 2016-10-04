(load "ex4.07-dgoon.scm")

(define (named-let? exp)
  (if (pair? (cadr exp))
      false
      true))

(define (named-let-var exp) (cadr exp))
(define (named-let-bindings exp) (caddr exp))
(define (named-let-body exp) (cadddr exp))

(define (expand-named-let exp)
  (let ((var (named-let-var exp))
	(bindings (named-let-bindings exp))
	(body (named-let-body exp)))
    (let ((vars (let-vars bindings))
	  (vals (let-vals bindings)))
      (make-begin (list (make-define var 
				     (make-lambda vars (list body)))
			(append (list var) vals))))))

(define (let-combination-new exp)
  (if (named-let? exp)
      (expand-named-let exp)
      (let-combination exp)))

(define (install-named-let)
  (put 'myeval 'let (lambda (exp env)
		      (myeval (let-combination-new exp) env))))

(install-named-let)
