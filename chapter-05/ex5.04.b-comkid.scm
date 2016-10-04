; Procedure
(define (expt b n)
    (define (expt-iter counter product)
        (if (= counter 0)
            product
            (expt-iter (- counter 1) (* b product))))
    (expt-iter n 1))

; Controller
(controller
    (assign counter (reg n))
    (assign product (const 1))
 expt-loop
    (test (op =) (reg counter) (const 0))
    (branch (label expt-done))
    (assign counter (op -) (reg counter) (const 1))
    (assign product (op *) (reg b) (reg product))
    (goto (label expt-loop))
 expt-done)

