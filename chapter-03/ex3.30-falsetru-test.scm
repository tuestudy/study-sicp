(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex3.30-falsetru.scm")

(define ex3.30-falsetru-tests
  (test-suite
   "Test for ex3.30-falsetru"

   (test-case
    "0b101 + 0b100 = 0b001 with carry"
    (define A (list (make-wire) (make-wire) (make-wire)))
    (define B (list (make-wire) (make-wire) (make-wire)))
    (define S (list (make-wire) (make-wire) (make-wire)))
    (define C (make-wire))
    (nipple-carry-adder A B S C)
    (set-signal! (car A) 1)
    (set-signal! (cadr A) 0)
    (set-signal! (caddr A) 1)
    (set-signal! (car B) 1)
    (set-signal! (cadr B) 0)
    (set-signal! (caddr B) 0)
    (set-signal! C 0)
    (propagate)

    (check-equal? (get-signal C) 1)
    (check-equal? (get-signal (car S)) 0)
    (check-equal? (get-signal (cadr S)) 0)
    (check-equal? (get-signal (caddr S)) 1))

   (test-case
    "0b010 + 0b101 = 0b111"
    (define A (list (make-wire) (make-wire) (make-wire)))
    (define B (list (make-wire) (make-wire) (make-wire)))
    (define S (list (make-wire) (make-wire) (make-wire)))
    (define C (make-wire))
    (nipple-carry-adder A B S C)
    (set-signal! (car A) 0)
    (set-signal! (cadr A) 1)
    (set-signal! (caddr A) 0)
    (set-signal! (car B) 1)
    (set-signal! (cadr B) 0)
    (set-signal! (caddr B) 1)
    (set-signal! C 0)
    (propagate)

    (check-equal? (get-signal C) 0)
    (check-equal? (get-signal (car S)) 1)
    (check-equal? (get-signal (cadr S)) 1)
    (check-equal? (get-signal (caddr S)) 1))
   ))

(exit
  (cond
    ((= (run-tests ex3.30-falsetru-tests) 0))
    (else 1)))
