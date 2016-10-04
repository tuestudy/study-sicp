(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (err amount)
    "Incorrect password\n")
  (define (dispatch pwd m)
    (if (not (eq? pwd password))
        err
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              (else (error "Unknown request -- MAKE-ACCOUNT"
                           m)))))
  dispatch)


; test

(define acc (make-account 100 'sesame!))

;((acc pwd m) amount)



(define (make-joint extacc curpwd newpwd)
  (define (dispatch pwd m)
    (if (eq? pwd newpwd)
        (extacc curpwd m)
        (extacc '() m)))
  dispatch)


(define acc2 (make-joint acc 'sesame! 'susemi!))


((acc 'sesame! 'deposit) 100)
((acc2 'susemi! 'withdraw) 100)
((acc2 'sesame! 'deposit) 100)
    
    
    
    