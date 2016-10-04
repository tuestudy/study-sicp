(load "ex2.77-falsetru.scm")

(define (conv x t)
  (if (eq? (type-tag x) t)
    x
    (let (( f(get-coercion (type-tag x) t)))
      (if f (f x) false))))

(define (all xs) (not (memq false xs)))
(define (repeat n x)
  (if (= n 0)
    null
    (cons x (repeat (- n 1) x))))

(define (apply-generic op . args)
  (define type-tags (map type-tag args))
  (define (filter1 op types args)
    (if (null? types)
      (error "No method for these types -- APPLY-GENERIC" (list op type-tags))
      (let ((t (car types)))
        (let ((new-args (map (lambda (x) (conv x t)) args)))
          (if (all new-args)
            (apply
              (get op (repeat (length args) t))
              (map contents new-args))
            (filter1 op (cdr types) args))))))
  (filter1 op type-tags args))

(put 'add4 '(rational rational rational rational)
     (lambda (a b c d)
       (attach-tag 'rational
                   (add-rat (add-rat a b) (add-rat c d)))))
(define (add4 a b c d) (apply-generic 'add4 a b c d))

(define (scheme-number->rational n) (make-rational (contents n) 1))
(put-coercion 'scheme-number 'rational scheme-number->rational)
