;; a. Recursive exponentiation
;; (define (expt b n)
;;   (if (= n 0)
;;       1
;;       (* b (expt b (- n 1)))))
; controller
(controller
 (assign b (op read))
 (assign n (op read))
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
 (assign t (op *) (reg n) (reg b))
 (goto (reg continue))
expt-done
 (assign val (reg t)))


;; b. Iterative exponentiation
;; (define (expt b n)
;;   (define (expt-iter counter product)
;;     (if (= counter 0)
;;         product
;;         (expt-iter (- counter 1) (* b product))))
;;   (expt-iter n 1))
(controller
 (assign b (op read))
 (assign n (op read))
 (assign c (reg n))
 (assign p (const 1))
expt-loop
 (test (op =) (reg c) (const 0))
 (branch expt-done)
 (assign c (op -) (reg c) (const 1))
 (assign p (op *) (reg b) (reg p))
 (goto (label expt-loop))
expt-done)
