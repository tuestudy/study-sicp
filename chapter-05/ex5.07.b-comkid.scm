(load "comkid-simulator.scm")

; Procedure
;
; (define (expt b n)
;     (define (expt-iter counter product)
;         (if (= counter 0)
;             product
;             (expt-iter (- counter 1) (* b product))))
;     (expt-iter n 1))
;

; register machine
(define expt-machine
  (make-machine
   '(b n counter product)
   (list (list '= =)
         (list '- -)
         (list '* *))
   '((assign counter (reg n))
     (assign product (const 1))
     expt-loop
     (test (op =) (reg counter) (const 0))
     (branch (label expt-done))
     (assign counter (op -) (reg counter) (const 1))
     (assign product (op *) (reg b) (reg product))
     (goto (label expt-loop))
     expt-done)))

(set-register-contents! expt-machine 'b 3)
(set-register-contents! expt-machine 'n 2)
(start expt-machine)
(get-register-contents expt-machine 'product)
