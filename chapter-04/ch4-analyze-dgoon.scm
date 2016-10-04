(load "ex4.21-dgoon.scm")

(define (myeval exp env)
  ((analyze exp) env))

(define (analyze exp)
  (cond ((self-evaluating? exp) (analyze-self-evaluating exp))
	((quoted? exp) (analyze-quoted exp))
	((variable? exp) (analyze-variable exp))
        ((assignment? exp) (analyze-assignment exp))
        ((definition? exp) (analyze-definition exp))
        ((if? exp) (analyze-if exp))
        ((lambda? exp) (analyze-lambda exp))
        ((begin? exp) (analyze-sequence (begin-actions exp)))
        ((cond? exp) (analyze (cond->if exp)))
        ((application? exp) (analyze-application exp))
        (else
         (error "Unknown expression type -- ANALYZE" exp))))

(define (analyze-self-evaluating exp)
  (lambda (env) exp))

(define (analyze-quoted exp)
  (let ((qval (text-of-quotation exp)))
    (lambda (env) qval)))

(define (analyze-variable exp)
  (lambda (env) (lookup-variable-value exp env)))

(define (analyze-assignment exp)
  (let ((var (assignment-variable exp))
        (vproc (analyze (assignment-value exp))))
    (lambda (env)
      (set-variable-value! var (vproc env) env)
      'ok)))

(define (analyze-definition exp)
  (let ((var (definition-variable exp))
        (vproc (analyze (definition-value exp))))
    (lambda (env)
      (define-variable! var (vproc env) env)
      'ok)))

(define (analyze-if exp)
  (let ((pproc (analyze (if-predicate exp)))
        (cproc (analyze (if-consequent exp)))
        (aproc (analyze (if-alternative exp))))
    (lambda (env)
      (if (true? (pproc env))
          (cproc env)
          (aproc env)))))

(define (analyze-lambda exp)
  (let ((vars (lambda-parameters exp))
        (bproc (analyze-sequence (lambda-body exp))))
    (lambda (env) (make-procedure vars bproc env))))

(define (analyze-sequence exps)
  (define (sequentially proc1 proc2)
    (lambda (env) (proc1 env) (proc2 env)))
  (define (loop first-proc rest-procs)
    (if (null? rest-procs)
        first-proc
        (loop (sequentially first-proc (car rest-procs))
              (cdr rest-procs))))
  (let ((procs (map analyze exps)))
    (if (null? procs)
        (error "Empty sequence -- ANALYZE"))
    (loop (car procs) (cdr procs))))

(define (analyze-application exp)
  (let ((fproc (analyze (operator exp)))
        (aprocs (map analyze (operands exp))))
    (lambda (env)
      (execute-application (fproc env)
                           (map (lambda (aproc) (aproc env))
                                aprocs)))))

(define (execute-application proc args)
  (cond ((primitive-procedure? proc)
         (apply-primitive-procedure proc args))
        ((compound-procedure? proc)
         ((procedure-body proc)
          (extend-environment (procedure-parameters proc)
                              args
                              (procedure-environment proc))))
        (else
         (error
          "Unknown procedure type -- EXECUTE-APPLICATION"
          proc))))

;; And write this analyze procedure in data-directed style
(define (myanalyze-assignment exp)
  (let ((var (assignment-variable exp))
        (vproc (myanalyze (assignment-value exp))))
    (lambda (env)
      (set-variable-value! var (vproc env) env)
      'ok)))

(define (myanalyze-lambda exp)
  (let ((vars (lambda-parameters exp))
        (bproc (myanalyze-sequence (lambda-body exp))))
    (lambda (env) (make-procedure vars bproc env))))

(define (myanalyze-definition exp)
  (let ((var (definition-variable exp))
        (vproc (myanalyze (definition-value exp))))
    (lambda (env)
      (define-variable! var (vproc env) env)
      'ok)))

(define (myanalyze-if exp)
  (let ((pproc (myanalyze (if-predicate exp)))
        (cproc (myanalyze (if-consequent exp)))
        (aproc (myanalyze (if-alternative exp))))
    (lambda (env)
      (if (true? (pproc env))
          (cproc env)
          (aproc env)))))

(define (myanalyze-application exp)
  (let ((fproc (myanalyze (operator exp)))
        (aprocs (map myanalyze (operands exp))))
    (lambda (env)
      (execute-application (fproc env)
                           (map (lambda (aproc) (aproc env))
                                aprocs)))))

(define (myanalyze-sequence exps)
  (define (sequentially proc1 proc2)
    (lambda (env) (proc1 env) (proc2 env)))
  (define (loop first-proc rest-procs)
    (if (null? rest-procs)
        first-proc
        (loop (sequentially first-proc (car rest-procs))
              (cdr rest-procs))))
  (let ((procs (map myanalyze exps)))
    (if (null? procs)
        (error "Empty sequence -- ANALYZE"))
    (loop (car procs) (cdr procs))))

(define (myanalyze exp)
  (cond ((self-evaluating? exp) (analyze-self-evaluating exp))
	((variable? exp) (analyze-variable exp))
	(else
	 (let ((op-impl (get 'myanalyze (operator exp))))
	   (if op-impl
	       (op-impl exp)
	       (myanalyze-application exp))))))

(define (install-myanalyze-package)
  (put 'myanalyze 'quote analyze-quoted)
  (put 'myanalyze 'set! myanalyze-assignment)
  (put 'myanalyze 'define myanalyze-definition)
  (put 'myanalyze 'if myanalyze-if)
  (put 'myanalyze 'lambda myanalyze-lambda)
  (put 'myanalyze 'begin (lambda (exp)
			   (myanalyze-sequence (begin-actions exp))))
  (put 'myanalyze 'cond (lambda (exp)
			  (myanalyze (cond->if exp)))))

(define (myeval exp env)
  ((myanalyze exp) env))

(install-myanalyze-package)


