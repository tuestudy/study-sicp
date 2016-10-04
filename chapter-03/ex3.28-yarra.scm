; 3.28

; OR-gate 를 만드시오.

(define (or-gate a1 a2 output)
  (define (or-action-procedure)
    (let ((new-value
          (logical-or (get-signal a1) (get-signal a2))))
      (after-delay or-gate-delay
                   (lambda ()
                     (set-signal! output new-value)))))
  (add-action! a1 or-action-procedure)
  (add-action! a2 or-action-procedure)
  'ok)

(define (logical-or a b)
  (cond ((or (> 0 a) (> a 1)) (error "Invalid signal" a))
        ((or (> 0 b) (> b 1)) (error "Invalid signal" b))
        (else (if (> (+ a b) 0)
                  1
                  0))))