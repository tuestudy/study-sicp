; code from book
(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))
; answer
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list a1 '+ a2))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list m1 '* m2))))

(define (sum? x)
  (and (pair? x) (eq? (cadr x) '+)))

(define (augend s) (car s))

(define (product? x)
  (and (pair? x) (eq? (cadr x) '*)))

(define (multiplicand p) (car p))

; answer
(define (addend s) 
  (cond ((null? (cdddr s)) (caddr s))
        ((product? (cddr s)) (make-product (caddr s) (cadddr (cdr s))))
        ((sum? (cddr s)) (make-sum (caddr s) (cadddr (cdr s))))))

(define (multiplier p)
  (cond ((null? (cdddr p)) (caddr p))
        ((product? (cddr p)) (make-product (caddr p) (cadddr (cdr p))))
        ((sum? (cddr p)) (make-sum (caddr p) (cadddr (cdr p))))))

; code from ex2.46
(define (exponentiation? x)
  (and (pair? x) (eq? (cadr x) '**)))

(define (base e) (car e))
(define (exponent e) (caddr e))

(define (make-exponentiation e1 e2)
  (cond ((=number? e2 0) 1)
        ((=number? e1 1) 1)
        ((=number? e2 1) e1)
        ((and (number? e1) (number? e2)) (expt e1 e2))
        (else (list e1 '** e2))))


(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv (multiplicand exp) var))
          (make-product (deriv (multiplier exp) var)
                        (multiplicand exp))))
        ((exponentiation? exp)
         (make-product (exponent exp)
                       (make-product
                        (make-exponentiation (base exp)
                                             (- (exponent exp) 1))
                        (deriv (base exp) var))))
        (else
         ((display "unknown expression type -- DERIV")
          (display exp)))))

; test-case
(and
 (eq? #t (sum? '(3 + 2)))
 (eq? 3 (augend '(3 + 2)))
 (eq? 2 (addend '(3 + 2)))
 
 (eq? #t (product? '(3 * 4)))
 (eq? 3 (multiplicand '(3 * 4)))
 (eq? 4 (multiplier '(3 * 4)))
 (equal? '(a + b) (make-sum 'a 'b))
 (equal? '(a * b) (make-product 'a 'b))
 (exponentiation? '(3 ** 2))
 (eq? 3 (base '(3 ** 2)))
 (eq? 2 (exponent '(3 ** 2))))

;expression
(eq? 1
     (deriv '(x + 3) 'x))
(eq? 'y
     (deriv '(x * y) 'x))
(equal? '(((x + 3) * y) + (x * y))
        (deriv '((x * y) * (x + 3)) 'x))
(eq? 4
     (deriv '(x + (3 * (x + (y + 2)))) 'x))
(eq? 4
     (deriv '(x + 3 * (x + y + 2)) 'x))
(equal? '((x + y + 2) + (x + 3))
        (deriv '((x + 3) * (x + y + 2)) 'x))




