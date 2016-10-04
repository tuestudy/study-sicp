; 3.29

; AND gate와 INVERTER로 OR gate를 만드시오.


; solution

(define (complex-or-gate a b out)
  (let ((w1 (make-wire))
        (w2 (make-wire))
        (w3 (make-wire)))
    (inverter a w1)
    (inverter b w2)
    (and-gate w1 w2 w3)
    (inverter w3 out)
    'ok))