; from problem description
(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))

(define (cc amount coin-values)
  (cond ((= amount 0) 1)
         ((or (< amount 0) (no-more? coin-values)) 0)
         (else
          (+ (cc amount
                 (except-first-denomination coin-values))
             (cc (- amount
                    (first-denomination coin-values))
                 coin-values)))))
; solving part
(define (no-more? a)
  (null? a))

(define (first-denomination a)
  (car a))

(define (except-first-denomination a)
  (cdr a))

; test-case
(= 292 (cc 100 us-coins))
(define us-coins2 (list 1 5 10 25 50))
(= 292 (cc 100 us-coins2))
(= 292 (cc 100 (list 1 10 5 50 25)))

; The order of list does not effect on the result.
