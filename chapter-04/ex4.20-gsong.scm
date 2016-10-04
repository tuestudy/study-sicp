; a
(define (letrec->let exp)
  (make-let (unassigned-letrec-vars (cadr exp)) (list (make-set-and-body exp))))

(define (unassigned-letrec-vars decls)
  (if (null? decls) '()
      (map (lambda (pair) (if (null? pair) '() (list (car pair) '*unassigned*))) decls)))

(define (make-set-and-body exp)
  (let
      ((letvars (cadr exp))
       (letbody (cddr exp)))
    (make-begin (append (map (lambda (pair) (make-set! (car pair) (cadr pair))) letvars) letbody))))

(define (eval-letrec exp env)
  (myeval (letrec->let exp) env))
(put 'letrec 'eval eval-letrec)