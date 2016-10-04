#lang racket

(require "stream-base-falsetru.scm")

(define (pairs s t)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (interleave
    (stream-map (lambda (x) (list (stream-car s) x))
                (stream-cdr t))
    (pairs (stream-cdr s) (stream-cdr t)))))

(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (interleave s2 (stream-cdr s1)))))

(define (stream-idx s x)
  (if (equal? (stream-car s) x)
    0
    (+ (stream-idx (stream-cdr s) x) 1)))

(define (guess-int-pairs-idx a b)
  (if (= a b)
    (- (expt 2 a) 2)
    (+ (- (* (expt 2 a) (- b a)) (expt 2 (- a 1))) (guess-int-pairs-idx a a))
    
    ))

(require rackunit)
(require rackunit/text-ui)

(define ex3.66-falsetru-tests
  (test-suite
   "Test for ex3.66-falsetru"

   (test-case
    ""
    (define int-pairs (pairs integers integers))
    (check-equal? (stream-idx int-pairs '(1 1)) 0)
    (check-equal? (stream-idx int-pairs '(1 2)) 1)
    (check-equal? (stream-idx int-pairs '(2 2)) 2)
    (check-equal? (stream-idx int-pairs '(1 3)) 3)
    (check-equal? (stream-idx int-pairs '(2 3)) 4)
    (check-equal? (stream-idx int-pairs '(1 4)) 5)
    (check-equal? (stream-idx int-pairs '(3 3)) 6)
    (check-equal? (stream-idx int-pairs '(1 5)) 7)
    (check-equal? (stream-idx int-pairs '(2 4)) 8)
    (check-equal? (stream-idx int-pairs '(1 6)) 9)
    (check-equal? (stream-idx int-pairs '(3 4)) 10)
    (check-equal? (stream-idx int-pairs '(1 7)) 11)
    (check-equal? (stream-idx int-pairs '(2 5)) 12)
    (check-equal? (stream-idx int-pairs '(1 100)) 197)

    (check-equal? (stream-idx int-pairs '(1 6)) (guess-int-pairs-idx 1 6))
    (check-equal? (stream-idx int-pairs '(3 4)) (guess-int-pairs-idx 3 4))
    (check-equal? (stream-idx int-pairs '(1 7)) (guess-int-pairs-idx 1 7))
    (check-equal? (stream-idx int-pairs '(2 5)) (guess-int-pairs-idx 2 5))
    (check-equal? (stream-idx int-pairs '(1 100)) (guess-int-pairs-idx 1 100))
    (printf "~a\n" (guess-int-pairs-idx 99 100))
    (printf "~a\n" (guess-int-pairs-idx 100 100))
    ;(printf "~a\n" (stream-idx int-pairs '(99 100))) ; maybe 950737950171172051122527404030
    ;(printf "~a\n" (stream-idx int-pairs '(100 100))) ; maybe 1267650600228229401496703205374
    )
   ))

(exit (run-tests ex3.66-falsetru-tests))
