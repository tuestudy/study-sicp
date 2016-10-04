; code from book
(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        ((eq? a1 a2) (list '* 2 a1))
        (else (list '+ a1 a2))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        ((eq? m1 m2) (list 'expt m1 2))
        (else (list '* m1 m2))))

; answer
(define (addend s)
  (cond ((= (length s) 3) (caddr s))
        (else (cons '+ (cddr s)))))

(define (multiplier p)
  (cond ((= (length p) 3) (caddr p))
        (else (cons '* (cddr p)))))

; code from book
(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))

(define (augend s) (cadr s))

(define (product? x)
  (and (pair? x) (eq? (car x) '*)))

(define (multiplicand p) (cadr p))

; code from ex2.46
(define (exponentiation? x)
  (and (pair? x) (eq? (car x) 'expt)))

(define (base e) (cadr e))
(define (exponent e) (caddr e))

(define (make-exponentiation e1 e2)
  (cond ((=number? e2 0) 1)
        ((=number? e1 1) 1)
        ((=number? e2 1) e1)
        ((and (number? e1) (number? e2)) (expt e1 e2))
        (else (list 'expt e1 e2))))


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

; expression
(deriv '(+ x 3) 'x)
(deriv '(* x y) 'x)
(deriv '(* x y (+ x 3)) 'x)


