;a.
(define (lookup-variable-value var env)
  (let
      ((value (find-var-action env var (lambda (frame) (cadr (first-pair frame))) '())))
    (if (eq? value '*unassigned*)
        (error "Unassigned variable : " var)
        value)))

;b.
(define (scan-out-defines proc_body)
  (list (make-let (unassigned-define-decls proc_body) (list (set-and-body proc_body)))))

(define (filter predicate sequence)
  (cond ((null? sequence) '())
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(define (notnull? obj)
  (not (null? obj)))

(define (unassigned-define-decls proc_body)
  (filter notnull? (map make-unassigned-var-decl proc_body)))

(define (make-unassigned-var-decl define-body)
  (if (definition? define-body)
      (list (definition-variable define-body) '*unassigned*)
      '()))

(define (set-and-body define-and-body)
  (make-begin (map make-set-body define-and-body)))

(define (make-set-body exp)
  (if (definition? exp)
      (make-set! (definition-variable exp) (definition-value exp))
      exp))

(define (make-set! var val)
  (list 'set! var val))