(define (variable? e) (symbol? e))
; e가 변수인지 알아본다.
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))
; v1과 v2가 같은 변수인지 따져본다.

(define (sum? e) (and (pair? e) (eq? (car e) '+)))
; e가 덧셈식인지 알아본다.
(define (augend e) (cadr e))
; 덧셈식 e에서 덧수를 골라낸다.
(define (addend e) (caddr e))
; 덧셈식 e에서 더하임수를 골라낸다.
(define (make-sum a1 a2) 
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list '+ a1 a2))))
; a1과 a2로 이루어진 덧셈식을 짜맞춘다.
(define (=number? exp num)
  (and (number? exp) (= exp num)))
; 숫자인 식 exp이 숫자 num과 같은지를 검사한다.

(define (product? e) (and (pair? e) (eq? (car e) '*)))
; e가 곱셈식인지 알아본다.
(define (multiplier e) (cadr e))
; 곱셈식 e에서 곱수를 골라낸다.
(define (multiplicand e) (caddr e))
; 곱셈식 e에서 곱하임수를 골라낸다.
(define (make-product m1 m2) 
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))))
; m1과 m2로 이루어진 곱셈식을 짜맞춘다.

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
                       (make-product (make-exponentiation (base exp) (- (exponent exp) 1))
                                     (deriv (base exp) var))))
        (else
         (error "unknown expression type -- DERIV" exp))))

(define (make-exponentiation base exponent) 
  (cond ((=number? base 0) 0)
        ((=number? exponent 0) 1)
        ((=number? exponent 1) base)
        ((and (number? base) (number? exponent)) (expt base exponent))
        (else (list '^ base exponent))))

(define (base exp) (cadr exp))

(define (exponent exp) (caddr exp))

(define (exponentiation? e) (and (pair? e) (eq? (car e) '^)))





         


