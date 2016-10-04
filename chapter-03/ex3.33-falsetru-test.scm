(require rackunit)
(require rackunit/text-ui)
(load "ex3.33-falsetru.scm")


;(define (celsius-fahrenheit-converter c f)
;  (let ((u (make-connector))
;        (v (make-connector))
;        (w (make-connector))
;        (x (make-connector))
;        (y (make-connector)))
;    (multiplier c w u)
;    (multiplier v x u)
;    (adder v y f)
;    (constant 9 w)
;    (constant 5 x)
;    (constant 32 y)
;    'ok))
;
;(celsius-fahrenheit-converter C F)
;(probe "Celsius temp" C)
;(probe "Fahrenheit temp" F)

;(set-value! C 25 'user)
;(forget-value! C 'user)
;(set-value! F 212 'user)



(define ex3.33-falsetru-tests
  (test-suite
   "Test for ex3.33-falsetru"

   (test-case
    "averager a b c"
    ; a=4, b=6, c=?
    (define a (make-connector))
    (define b (make-connector))
    (define c (make-connector))
    (averager a b c)
    (set-value! a 4 'user)
    (set-value! b 6 'user)
    (check-equal? (get-value c) 5)
    
    ; a=4, b=?, c=4
    (forget-value! b 'user)
    (forget-value! c 'user)
    (set-value! c 4 'user)
    (check-equal? (get-value b) 4)

    ; a=?, b=8, c=4
    (forget-value! a 'user)
    (forget-value! b 'user)
    (set-value! b 8 'user)
    (check-equal? (get-value a) 0)
    )
   ))

(exit
  (cond
    ((= (run-tests ex3.33-falsetru-tests) 0))
    (else 1)))
