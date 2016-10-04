(define (or-gate a b c)
  (define na (make-wire))
  (define nb (make-wire))
  (define nanb (make-wire))
  (inverter a na)
  (inverter b na)
  (and-gate na nb nanb)
  (inverter nanb c))

; or-gate-delay = inverter-delay + and-gate-delay + inverter-delay
;               = 2 * inverter-delay + and-gate-delay
