; 2.54 

(load "../misc/scheme-test.scm")

(define (xor a b) (or (and a (not b)) (and (not a) b)))

(define (equal2? lst1 lst2)
  (if (= (length lst1) (length lst2))
      (if (null? lst1)
          #t
          (if (eq? (car lst1) (car lst2))
              (equal2? (cdr lst1) (cdr lst2))
              #f))
      #f))

(define (equal3? lst1 lst2)
  (if (xor (null? lst1) (null? lst2))
      #f
      (if (and (null? lst1) (null? lst2))
          #t
          (if (eq? (car lst1) (car lst2))
              (equal3? (cdr lst1) (cdr lst2))
              #f))))



(run
 (make-testcase
  '(assert-true? (equal3? '(this is a list) '(this is a list)))
  '(assert-false? (equal3? '(this is a list) '(this (is a) list)))))