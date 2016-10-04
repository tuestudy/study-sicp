(define (make-acount balance password)
  (define wrong-try 0)
  (define (withdraw amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (call-the-cops)
    "Call the cops")
  (define (incorrect-password amount)
    (set! wrong-try (+ wrong-try 1))
    (if (>= wrong-try 7)
      (call-the-cops)
      "Incorrect password"))
  (define (dispatch pw m)
    (cond ((not (eq? pw password)) incorrect-password)
          ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request -- MAKE-ACCOUNT"
                       m))))
  dispatch)

