(load "../misc/scheme-test.scm")

;2.59 by gsong
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))
(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))
(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

(define (union-set set1 set2)
  (if (null? set2) set1
      (union-set (adjoin-set (car set2) set1) (cdr set2))))

(define (set-equal? set1 set2)
  (if (and (= (length set1) (length set2)) (= (length set1) (length (intersection-set set1 set2))))
      #t
      #f))

(run (make-testcase
      '(assert-equal? (set-equal? (union-set '(1 2) '()) '(1 2)) #t)
      '(assert-equal? (set-equal? (union-set '(1 2) '(3 4)) '(4 3 1 2)) #t)
      '(assert-equal? (set-equal? (union-set '(1 2 3) '(3 4 5)) '(5 4 1 2 3)) #t)
      '(assert-equal? (set-equal? '(1 2) '(1 2)) #t)
      '(assert-equal? (set-equal? '(1 2) '(3 4)) #f)
      '(assert-equal? (set-equal? '(1 2 3) '(3 2 1)) #t)
      ))