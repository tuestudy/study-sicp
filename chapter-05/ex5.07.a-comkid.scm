(load "comkid-simulator.scm")

; procedure
;
; (define (expt b n)
;     (if (= n 0)
;         1
;         (* b (expt b (- n 1)))))
;

; register machine
(define expt-machine
    (make-machine
        '(b n val continue)
        (list (list '= =)
              (list '- -)
              (list '* *))
        '(
            (assign continue (label expt-done))
          expt-loop
            (test (op =) (reg n) (const 0))
            (branch (label base-case))
            (save continue)
            (assign n (op -) (reg n) (const 1))
            (assign continue (label after-expt))
            (goto (label expt-loop))
          after-expt
            (assign val (op *) (reg b) (reg val))
            (restore continue)
            (goto (reg continue))
          base-case
            (assign val (const 1))
            (goto (reg continue))
          expt-done)))

(set-register-contents! expt-machine 'b 3)
(set-register-contents! expt-machine 'n 2)
(start expt-machine)
(get-register-contents expt-machine 'val)
