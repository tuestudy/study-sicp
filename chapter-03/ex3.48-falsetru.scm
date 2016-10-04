(define (parallel-execute . thunks)
  (map thread-wait (map thread thunks)))

(define (make-serializer)
  (let ((mutex (make-semaphore 1)))
    (lambda (p)
      (define (serialized-p . args)
        (semaphore-wait mutex)
        (let ((val (apply p args)))
          (semaphore-post mutex)
          val))
      serialized-p)))

(define (make-account number balance)
  (define (withdraw amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Insufficent funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (let ((balance-serializer (make-serializer)))
    (define (dispatch m)
      (cond [(eq? m 'number) number]
            [(eq? m 'balance) balance]
            [(eq? m 'withdraw) withdraw]
            [(eq? m 'deposit) deposit]
            [(eq? m 'serializer) balance-serializer]
            ))
    dispatch))

(define (exchange account1 account2)
  (let ((difference (- (account1 'balance)
                       (account2 'balance))))
    ((account1 'withdraw) difference)
    ((account2 'deposit) difference)))

(define (serialized-exchange account1 account2)
  (let ((serializer1 (account1 'serializer))
        (serializer2 (account2 'serializer)))
    (if (< (account1 'number) (account2 'number))
      ((serializer2 (serializer1 exchange))
       account1 account2)
      ((serializer1 (serializer2 exchange))
       account1 account2))))


(require rackunit)
(require rackunit/text-ui)

(define serialized-exchange-tests
  (test-suite
   "Test for serialized-exchange"

   (test-case
    ""
    (define a1 (make-account 1 5000))
    (define a2 (make-account 2 10000))

    (parallel-execute (lambda () (serialized-exchange a1 a2))
                      (lambda () (serialized-exchange a1 a2))
                      (lambda () (serialized-exchange a1 a2))
                      (lambda () (serialized-exchange a1 a2))
                      (lambda () (serialized-exchange a1 a2))
                      )
    
    (check-equal? (a1 'balance) 10000)
    (check-equal? (a2 'balance) 5000)
    )
   ))

(exit (run-tests serialized-exchange-tests))
