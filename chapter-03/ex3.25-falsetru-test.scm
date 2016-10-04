(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex3.25-falsetru.scm")

(define ex3.25-falsetru-tests
  (test-suite
   "Test for ex3.25-falsetru"

   (check-equal? (mk-rec '(1) 2)
                 (cons 1 2))
   (check-equal? (mk-rec '(a b) 3)
                 (cons 'a (list (cons 'b 3)))
                 )
   (test-case
    "1 key"
    (define t (make-table))
    (define get (t 'lookup-proc))
    (define put (t 'insert-proc!))
    (put '(a) 3)
    (check-equal? (t 'length) 1)
    (put '(a) 4)
    (check-equal? (t 'length) 1)
    (put '(b) 5)
    (check-equal? (t 'length) 2)
    (check-equal? (get '(a)) 4)
    (check-equal? (get '(b)) 5)
    (check-equal? (get '(c)) false))
   (test-case
    "2 keys"
    (define t (make-table))
    (define get (t 'lookup-proc))
    (define put (t 'insert-proc!))
    (put '(a b) 3)
    (put '(a b) 4)
    (put '(a x) 5)
    (check-equal? (t 'print) '(*table* (a (x . 5) (b . 4))))
    (check-equal? (get '(a b)) 4)
    (check-equal? (get '(a x)) 5)
    (check-equal? (get '(a c)) false))
   (test-case
    "3 keys"
    (define t (make-table))
    (define get (t 'lookup-proc))
    (define put (t 'insert-proc!))
    (put '(a a a) 1)
    (put '(z a a) 2)
    (put '(a b a) 3)
    (put '(a b c) 4)
    (check-equal? (get '(a a a)) 1)
    (check-equal? (get '(z a a)) 2)
    (check-equal? (get '(a b a)) 3)
    (check-equal? (get '(a b c)) 4)
    (put '(a b c) 5)
    (check-equal? (get '(a b c)) 5)
    (check-equal? (t 'print)
                  '(*table*
                     (z (a (a . 2)))
                     (a (b (c . 5)
                           (a . 3))
                        (a (a . 1))))))
   (test-case
    "* keys"
    (define t (make-table))
    (define get (t 'lookup-proc))
    (define put (t 'insert-proc!))
    (put '(a) 1)
    (put '(b) 2)
    (put '(c d) 3)
    (check-equal? (t 'print)
                  '(*table*
                     (c (d . 3))
                     (b . 2)
                     (a . 1)))
    (check-equal? (get '(a)) 1)
    (check-equal? (get '(b)) 2)
    (check-equal? (get '(c d)) 3)
    (put '(b a) 2)
    (put '(b b) 3)
    (check-equal? (get '(a)) 1)
    (check-equal? (get '(b a)) 2)
    ;(check-equal? (get '(b)) 'sub-table-with-garbage)
    (check-equal? (get '(c d)) 3)
    (put '(b) 2)
    (check-equal? (get '(b)) 2)
    )

   ))

(exit
  (cond
    ((= (run-tests ex3.25-falsetru-tests) 0))
    (else 1)))
