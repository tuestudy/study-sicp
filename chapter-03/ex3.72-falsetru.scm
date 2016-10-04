#lang racket

(require "stream-base-falsetru.scm")
(require "ex3.70-falsetru.scm")

(define (find-3-consecutive s f)
  (define (consecutive-aux s prev acc)
    (if (equal? (f (stream-car s)) (f prev))
      (if (= (+ (length acc) 1) 3)
        (cons-stream (cons (stream-car s) acc)
                     (consecutive-aux (stream-cdr s) prev (cons (stream-car s) acc)))
        (consecutive-aux (stream-cdr s) prev (cons (stream-car s) acc)))
      (consecutive-aux (stream-cdr s) (stream-car s) (list (stream-car s)))))
  (consecutive-aux (stream-cdr s) (stream-car s) (list (stream-car s))))

(define (square x) (* x x))
(define (pair-square-sum x) (+ (square (car x)) (square (cadr x))))
(define candidates (weighted-pairs integers integers pair-square-sum))
(define result (find-3-consecutive candidates pair-square-sum))

(require rackunit)
(require rackunit/text-ui)

(define ex3.72-tests
  (test-suite
   "Test for ex3.72"

   (check-equal? (stream-take result 10)
                 '(((10 15) (6 17) (1 18))
                   ((13 16) (8 19) (5 20))
                   ((17 19) (11 23) (5 25))
                   ((14 23) (10 25) (7 26))
                   ((19 22) (13 26) (2 29))
                   ((15 25) (11 27) (3 29))
                   ((21 22) (14 27) (5 30))
                   ((20 25) (8 31) (1 32))
                   ((12 31) (9 32) (4 33))
                   ((25 25) (17 31) (5 35)))
                 )
   ))

(exit (run-tests ex3.72-tests))

