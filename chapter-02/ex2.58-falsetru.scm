(load "ex2.56-falsetru.scm")

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list a1 '+ a2))))
(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2) (* m1 m2)))
        (else (list m1 '* m2))))

(define (rest exp)
  (if (= (length exp) 3)
    (caddr exp)
    (cddr exp)))
(define (sum? x) (and (pair? x) (eq? (cadr x) '+)))
(define augend car)
(define addend rest)
(define (product? x) (and (pair? x) (eq? (cadr x) '*)))
(define multiplicand car)
(define multiplier rest)

(define (** exp num)
  (cond ((=number? num 0) 1)
        ((=number? num 1) exp)
        ((and (number? exp) (number? num)) (expt exp num))
        (else (list exp '** num))))
(define (exp? x) (and (pair? x) (eq? (cadr x) '**)))
(define base car)
(define exponent rest)
