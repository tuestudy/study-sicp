(define (myeval exp env)
  (define (operator exp) (car exp))
  (define (operands exp) (cdr exp))
  (display "myeval:") (display exp) (newline)
  (cond 
    ((null? exp) (display "MYEVAL NULL EXPRESSION") (newline) '())
    ((self-evaluating? exp) exp)
    ((variable? exp) (lookup-variable-value exp env))
    (else
     (let ((op (get (operator exp) 'eval)))
       (if op
           (op exp env)
           (myapply (actual-value (operator exp) env)
                    (operands exp)
                    env))))))

(define (actual-value exp env)
  (display "actual-value") (newline)
  (display exp) (newline)
  (force-it (myeval exp env)))

(define (myapply procedure arguments env)
  (cond ((primitive-procedure? procedure)
         (display "primitive-procedure") (newline)
         (apply-primitive-procedure
          procedure
          (list-of-arg-values arguments env)))
        ((compound-procedure? procedure)
         (display "compound procedure!") (newline)
         (eval-sequence
          (procedure-body procedure)
          (extend-environment
           (procedure-parameters procedure)
           (list-of-delayed-args arguments env) ; changed
           (procedure-environment procedure))))
        (else
         (error "Unknown procedure type -- APPLY" procedure))))

(define (list-of-arg-values exps env)
  (if (no-operands? exps)
      '()
      (cons (actual-value (first-operand exps) env)
            (list-of-arg-values (rest-operands exps)
                                env))))

(define (list-of-delayed-args exps env)
  (if (no-operands? exps)
      '()
      (cons (delay-it (first-operand exps) env)
            (list-of-delayed-args (rest-operands exps)
                                  env))))

(define (eval-if exp env)
  (if (true? (actual-value (if-predicate exp) env))
      (myeval (if-consequent exp) env)
      (myeval (if-alternative exp) env)))

(define (prompt-for-input string)
  (newline) (newline) (display string) (newline))

(define (announce-output string)
  (newline) (display string) (newline))


(define (force-it obj)
  (display "force-it(")(display (thunk? obj)) (display ":") (display obj) (newline)
  (if (thunk? obj)
      (actual-value (thunk-exp obj) (thunk-env obj))
      obj))

(define (delay-it exp env)
  (list 'thunk exp env))

(define (thunk? obj)
  (tagged-list? obj 'thunk))

(define (thunk-exp thunk) (cadr thunk))

(define (thunk-env thunk) (caddr thunk))
(define (user-print object)
  (if (compound-procedure? object)
      (display (list 'compound-procedure
                     (procedure-parameters object)
                     (procedure-body object)
                     '<procedure-env>))
      (display object)))


(define (evaluated-thunk? obj)
  (tagged-list? obj 'evaluated-thunk))

(define (thunk-value evaluated-thunk) (cadr evaluated-thunk))
(define (force-it obj)
  (cond ((thunk? obj)
         (let ((result (actual-value
                        (thunk-exp obj)
                        (thunk-env obj))))
           (set-car! obj 'evaluated-thunk)
           (set-car! (cdr obj) result)  ; replace exp with its value
           (set-cdr! (cdr obj) '())     ; forget unneeded env
           result))
        ((evaluated-thunk? obj)
         (thunk-value obj))
        (else obj)))
