; 3.03

(load "../misc/scheme-test.scm")

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

(run
 (make-testcase
  '(assert-equal? 60 ((acc 'sesame! 'withdraw) 40))
  '(assert-equal? "Incorrect password\n" ((acc 'susemi! 'deposit) 50))
  '(assert-equal? 20 ((acc 'sesame! 'withdraw) 40))
  '(assert-equal? 100 ((acc 'sesame! 'deposit) 80))))



