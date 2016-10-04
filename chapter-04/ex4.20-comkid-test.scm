(load "ch4-myeval-pkg-comkid.scm")
(load "ex4.11-comkid.scm")
(load "ex4.12-comkid.scm")
(load "ex4.13-comkid.scm")
(load "ex4.16.a-comkid.scm")
(load "ex4.16.b-comkid.scm")
(load "ex4.16.c-comkid.scm")
(load "ex4.20-comkid.scm")
(load "../misc/scheme-test-r5rs.scm")

(define env (setup-environment))

(define expected-exp1
  '(let ((fact '*unassigned*))
     (set! fact (lambda (n)
                  (if (= n 1)
                      1
                      (* n (fact (- n 1))))))
     (fact 10)))

(define test-exp1
  '(letrec ((fact
             (lambda (n)
               (if (= n 1)
                   1
                   (* n (fact (- n 1)))))))
     (fact 10)))

(define expected-unassigned-vardecls '((a '*unassigned*) (b '*unassigned*)))
(define test-unassigned-vardecls '((a 10) (b 1)))

(define expected-set-vardecls1 '((set! a 10) (set! b 1)))
(define test-set-vardecls1 '((a 10) (b 1)))

(define expected-set-vardecls2 
  '((set! fact (lambda (n)
                 (if (= n 1)
                     1
                     (* n (fact (- n 1))))))))
(define test-set-vardecls2 
  '((fact
     (lambda (n)
       (if (= n 1)
           1
           (* n (fact (- n 1))))))))

(display "[ex4.20 - Tests]\n")
(run (make-testcase
      
      '(assert-equal? expected-unassigned-vardecls 
                      (unassigned-vardecls test-unassigned-vardecls))
      '(assert-equal? expected-set-vardecls1 
                      (set-vardecls test-set-vardecls1))
      '(assert-equal? expected-set-vardecls2 
                      (set-vardecls test-set-vardecls2))
      '(assert-equal? expected-exp1 
                      (letrec->let test-exp1))      
      '(assert-equal? 3628800 (myeval test-exp1 env))
      ))
