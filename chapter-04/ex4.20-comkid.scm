; 1.3.2 Constructing Procedures Using Lambda
;   - Using let

;(let ((fact
;       (lambda (n)
;         (if (= n 1)
;             1
;             (* n (fact (- n 1)))))))
;  (fact 10))
;
;((lambda (fact) 
;   (fact 10)) 
; (if (= n 1) 
;     1 
;     (* n (fact (- n 1)))))

(define (unassigned-vardecls decls)
  (map (lambda (decl) (list (car decl) ''*unassigned*)) decls))

(define (set-vardecls decls)
  (map (lambda (decl) (list 'set! (car decl) (cadr decl))) decls))

(define (letrec->let exp)
  (let ((vardecls (cadr exp))
        (body (cddr exp)))
    (append (list 'let  (unassigned-vardecls vardecls))
            (set-vardecls vardecls) 
            body)))

