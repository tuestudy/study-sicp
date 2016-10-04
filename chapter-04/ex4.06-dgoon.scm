(load "ex4.05-dgoon.scm")

; selectors
(define (let-exps clause) (cadr clause))
(define (let-body clause) (cddr clause))
(define (let-vars exps) (map car exps))
(define (let-vals exps) (map cadr exps))

; assembler
;(define (make-lambda vars body vals)
;  (define _definition (list (list 'lambda
;				  vars
;				  body)))
;  (append _definition vals))

(define (let-combination exp)
  (let ((exps (let-exps exp))
	(body (let-body exp)))
    (let ((vars (let-vars exps))
	  (vals (let-vals exps)))
      (append (list (make-lambda vars body))
	      vals))))

(define (install-let-combination)
  (put 'myeval 'let (lambda (exp env)
		      (myeval (let-combination exp) env))))

(install-let-combination)
