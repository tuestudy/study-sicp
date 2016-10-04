(load "ch4-myeval-pkg-gsong.scm")
(load "../misc/scheme-test-r5rs.scm")
(load "ex4.14-test-gsong.scm")

(define tge (setup-environment))

(display "[ex4.16 - Tests]\n")
; a.
(myeval '(define x '*unassigned*) tge)
(myeval '(define y 10) tge)

; b.
(define test_exp
  '((define (internal_func) 0)
  (internal_func a)))

(define expected_exp
  '((let ((internal_func *unassigned*))
     (begin
       (set! internal_func (lambda () 0))
       (internal_func a)))))

(define define_test_exp
  '(define (test1 a)
     (let ((internal_func '*unassigned*))
       (begin
         (set! internal_func (lambda () 1))
         (internal_func a)))))

(define test_exp2
  '((define (internal_func a) (+ a 1))
  (internal_func a)))

(define expected_exp2
  '((let ((internal_func *unassigned*))
     (begin
       (set! internal_func (lambda (a) (+ a 1)))
       (internal_func a)))))

(define test_exp3
  '((define (internal_func a) (+ a 1))
    (define (internal_func2 a b) (+ a b))
    (define (internal_func3 a) (+ (internal_func a) (internal_func2 a 5)))
    (internal_func3 a)))

(define expected_exp3
  '((let
       ((internal_func *unassigned*)
        (internal_func2 *unassigned*)
        (internal_func3 *unassigned*))
     (begin
       (set! internal_func (lambda (a) (+ a 1)))
       (set! internal_func2 (lambda (a b) (+ a b)))
       (set! internal_func3 (lambda (a) (+ (internal_func a) (internal_func2 a 5))))
       (internal_func3 a)))))

(define test_exp4
  '((define (internal_func a) (+ (internal_func2 a) (internal_func3 a 3)))
    (define (internal_func2 a) (+ a 5))
    (define (internal_func3 a b) (+ a b))
    (internal_func n)))

(define expected_exp4
  '((let
       ((internal_func *unassigned*)
        (internal_func2 *unassigned*)
        (internal_func3 *unassigned*))
     (begin
       (set! internal_func (lambda (a) (+ (internal_func2 a) (internal_func3 a 3))))
       (set! internal_func2 (lambda (a) (+ a 5)))
       (set! internal_func3 (lambda (a b) (+ a b)))
       (internal_func n))))
  )

(define test_exp_c3
  '(define (fc3 x)
     (let
       ((internal_func '*unassigned*)
        (internal_func2 '*unassigned*)
        (internal_func3 '*unassigned*))
     (begin
       (set! internal_func (lambda (a) (+ (internal_func2 a) (internal_func3 a 3))))
       (set! internal_func2 (lambda (a) (+ a 5)))
       (set! internal_func3 (lambda (a b) (+ a b)))
       (internal_func x)))))

(define test_exp_c1
  '(define (f x)
     (define (even? n)
       (if (= n 0)
           true
           (odd? (- n 1))))
     (define (odd? n)
       (if (= n 0)
           false
           (even? (- n 1))))
     (if (even? x) 'even 'odd)))

(define test_exp_c2
  '(define (f2 x)
     (let
         ((even? *unassigned*)
          (odd? *unassigned*))
       (begin
         (set! even? (lambda (n) (if (= n 0) true (odd? (- n 1)))))
         (set! odd? (lambda (n) (if (= n 0) false (even? (- n 1)))))
         (if (even? x) 'even 'odd)))))

(run (make-testcase
      ; let tests
      '(assert-equal? 1 (myeval '(car '(1 a)) tge))
      '(assert-equal? 3 (myeval '(+ 2 1) tge))
      '(assert-equal? 3 (myeval '(let ((a 1) (b 2)) (+ a b)) tge))
      '(assert-equal? 3 (myeval '(let () (+ 1 2)) tge))

      ; a. tests
      '(assert-equal? '() (lookup-variable-value 'x tge))
      '(assert-equal? 10 (lookup-variable-value 'y tge))
      
      ; b. tests
      '(assert-equal? 'ok (myeval define_test_exp tge))
      '(assert-equal? 1 (myeval '(test1 3) tge))
      
      '(assert-equal? expected_exp4 (scan-out-defines test_exp4))
      '(assert-equal? expected_exp3 (scan-out-defines test_exp3))
      '(assert-equal? expected_exp (scan-out-defines test_exp))
      '(assert-equal? expected_exp2 (scan-out-defines test_exp2))
      '(assert-equal? '(begin (set! internal_func (lambda (a) (+ a 1)))
                        (set! internal_func2 (lambda (a b) (+ a b)))
                        (set! internal_func3 (lambda (a) (+ (internal_func a) (internal_func2 a 5))))
                        (internal_func3 a))
                      (set-and-body test_exp3))
      '(assert-equal? '(begin
                         (set! internal_func (lambda (a) (+ a 1)))
                         (internal_func a))
                      (set-and-body test_exp2))
      '(assert-equal? '(begin 
                         (set! internal_func (lambda () 0))
                        (internal_func a))
                      (set-and-body test_exp))
      '(assert-equal? '(+ a b) (make-set-body '(+ a b)))
      '(assert-equal? '(set! func (lambda (a) (+ a 1)))
                      (make-set-body '(define (func a) (+ a 1))))
      '(assert-equal? '(set! func (lambda () 0))
                      (make-set-body '(define (func) 0)))
      '(assert-equal? '((internal_func *unassigned*)
                        (internal_func2 *unassigned*)
                        (internal_func3 *unassigned*))
                      (unassigned-define-decls test_exp3))
      '(assert-equal? '((func1 *unassigned*)
                        (func2 *unassigned*)
                        (func3 *unassigned*))
                      (unassigned-define-decls
                       '((define (func1 a) 0)
                         (define (func2 a b) a)
                         (define (func3 a b c) (+ a b c)))))
      '(assert-equal? '(func1 *unassigned*) (make-unassigned-var-decl '(define (func1 a b c) (+ a b c))))
      '(assert-equal? '() (make-unassigned-var-decl '(lambda (a) (+ a 1))))
      
      ; c. tests
      ; case 1. Scan out at make-procedure
      '(assert-equal? 'ok (myeval '(define (addtwo x y) (+ x y)) tge))
      '(assert-equal? 'ok (myeval test_exp_c3 tge))
      '(assert-equal? 18 (myeval '(fc3 5) tge))
      '(assert-equal? 'ok (myeval test_exp_c1 tge))
      '(assert-equal? 'even (myeval '(f 6) tge))
      '(assert-equal? 'odd (myeval '(f 5) tge))
      '(assert-equal? 'ok (myeval test_exp_c2 tge))
      '(assert-equal? 'even (myeval '(f 6) tge))
      '(assert-equal? 'odd (myeval '(f 5) tge))
      ))
