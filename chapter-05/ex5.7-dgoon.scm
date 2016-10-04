(load "dgoon-simulator.scm")

(define expt-recur-machine
  (make-machine
   '(b n continue t val)
   (list (list '= =)
	 (list '- -)
	 (list '* *)
	 ;(list 'save (stack push))
	 ;(list 'restore (stack pop)))
  )
   '(controller
     (assign continue (label expt-done))
     expt-loop
     (test (op =) (reg n) (const 0))
     (branch (label end-case))
     (save continue)
     (save n)
     (assign n (op -) (reg n) (const 1))
     (assign continue (label after-expt))
     (goto (label expt-loop))
     end-case
     (assign t (const 1))
     after-expt
     (restore n)
     (restore continue)
     (assign t (op *) (reg t) (reg b))
     (goto (reg continue))
     expt-done
     (assign val (reg t)))))


(set-register-contents! expt-recur-machine 'b 7)
(set-register-contents! expt-recur-machine 'n 5)
(start expt-recur-machine)
(display (get-register-contents expt-recur-machine 'val))(newline)

(define expt-iter-machine
  (make-machine
   '(b n c p)
   (list (list '= =)
	 (list '- -)
	 (list '* *))
   '(controller
     (assign c (reg n))
     (assign p (const 1))
     expt-loop
     (test (op =) (reg c) (const 0))
     (branch (label expt-done))
     (assign c (op -) (reg c) (const 1))
     (assign p (op *) (reg b) (reg p))
     (goto (label expt-loop))
     expt-done)))

(set-register-contents! expt-iter-machine 'b 7)
(set-register-contents! expt-iter-machine 'n 5)
(start expt-iter-machine)
(display (get-register-contents expt-iter-machine 'p))(newline)
