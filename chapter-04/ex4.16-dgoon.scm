(load "ex4.13-dgoon.scm")

; a. change lookup-variable-value
(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
	     (let ((val (car vals)))
	       (if (eq? val '*unassigned*)
		   (error "Binding to UNASSIGNED:" var)
		   val)))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))

; b. Write scan-out-defines
(define (collect-definitions body)
  (filter (lambda (x) (definition? x)) body))

(define (definition-vars define-exps)
  (map cadr define-exps))

(define (definition-bodies define-exps)
  (map caddr define-exps))

(define (make-initial-bindings vars)
  (map (lambda (var) (list var ''*unassigned*)) vars))

(define (make-set!s vars bodies)
  (map (lambda (var body) (list 'set! var body))
       vars bodies))

(define (exclude-definitions body)
  (filter (lambda (x) (not (definition? x)))
	  body))

(define (scan-out-defines body)
  (let ((define-exps (collect-definitions body)))
    (if (null? define-exps)
	(begin
	  ;(display "No define: ")(display body)(newline)
	  body)
	(let ((def-vars (definition-vars define-exps))
	      (def-bodies (definition-bodies define-exps)))
	  (list
	   (append
	    (list 'let
		  (make-initial-bindings (definition-vars define-exps)))
	    (make-set!s
	     (definition-vars define-exps)
	     (definition-bodies define-exps))
	    (exclude-definitions body)))))))

; Install scan-out-defines to execute scanned-out exp

(define (make-procedure-2 parameters body env)
  ;(display "MY Make-procedure with SCAN-OUT-DEFINES\n")
  ;(display "\tParameters:")(display parameters)(newline)
  ;(display "\tBody:\n")(display body)(newline)
  ;(display "\tConverted body:\n")(display (scan-out-defines body))(newline)
  (list 'procedure
	parameters
	(scan-out-defines body)
	env))

(define (install-scan-out)
  (set! make-procedure make-procedure-2))

;(install-scan-out)