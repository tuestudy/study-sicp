; 3.04

(load "../misc/scheme-test.scm")


; solution 

(define (make-account balance password)
  (define kaisu 0)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! kaisu 0) (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (begin (set! kaisu 0) (set! balance (+ balance amount)) "piyo piyo")
    balance)
  (define (err amount)
    (if (>= kaisu 7)
        (begin (set! kaisu 0) "piyo piyo")
        (begin (set! kaisu (+ 1 kaisu)) "Incorrect password")))
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
  '(assert-equal? "Incorrect password" ((acc 'susemi! 'deposit) 10))
  '(assert-equal? "Incorrect password" ((acc 'susemi! 'deposit) 10))
  '(assert-equal? "Incorrect password" ((acc 'susemi! 'deposit) 10))
  '(assert-equal? "Incorrect password" ((acc 'susemi! 'deposit) 10))
  '(assert-equal? "Incorrect password" ((acc 'susemi! 'deposit) 10))
  '(assert-equal? "Incorrect password" ((acc 'susemi! 'deposit) 10))
  '(assert-equal? "Incorrect password" ((acc 'susemi! 'deposit) 10))
  '(assert-equal? "piyo piyo" ((acc 'susemi! 'deposit) 10))))