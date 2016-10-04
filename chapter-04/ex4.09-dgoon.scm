(load "ex4.08-dgoon.scm")

(define (while? exp) (eq? 'while (car exp)))
(define (while-bindings exp) (cadr exp))
(define (while-predicate exp) (caddr exp))
(define (while-body exp) (cadddr exp))

(define (while->named-let exp)
  (let ((bindings (while-bindings exp))
	(predicate (while-predicate exp))
	(body (while-body exp)))
    (let ((vars (map car bindings)))
      (list 'let
	    '_while
	    bindings
	    (list 'let
		  (list (list 'body
			      body))
		  (make-if (list predicate)
			   (append (list '_while) vars)
			   'body))))))

