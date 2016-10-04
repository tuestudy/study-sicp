; 3.24


; solutions
(define (make-table same-key?)
  (let ((local-table (list '*table*)))
    (define (lookup key1 key2)
      (let ((subtable (assoc2 key1 (cdr local-table))))
        (if subtable
            (let ((record (assoc2 key2 (cdr subtable))))
              (if record
                  (cdr record)
                  #f))
            #f)))
    (define (insert! key1 key2 value)
      (let ((subtable (assoc2 key1 (cdr local-table))))
        (if subtable
            (let ((record (assoc2 key2 (cdr subtable))))
              (if record
                  (set-cdr! record value)
                  (set-cdr! subtable
                            (cons (cons key2 value)
                                  (cdr subtable)))))
            (set-cdr! local-table
                      (cons (list key1
                                  (cons key2 value))
                            (cdr local-table)))))
      'ok)
    (define (assoc2 key records)
      (cond ((null? records) #f)
            ((same-key? key (caar records)) (car records))
            (else (assoc2 key (cdr records)))))
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))



; test

(define (neeer? a b)
  (let ((tole 1))
    (if (< (abs (- b a)) tole)
        #t
        #f)))

(define tata (make-table neeer?))
(define get (tata 'lookup-proc))
(define put (tata 'insert-proc!))

(put 100 100 999)
; ok
(get 99.9999999 100.0000001)
; 999