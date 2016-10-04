(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.11-falsetru.scm")

(define (check-mul n1 n2 n3 n4) 
  (define (eql-interval? a b) 
    (cond ((and (= (upper-bound a) (upper-bound b)) 
                (= (lower-bound a) (lower-bound b))) true)
          (else
            (display "args: ")
            (display n1)
            (display ",")
            (display n2)
            (display ",")
            (display n3)
            (display ",")
            (display n4)
            (newline)
            false)))
  (let ((a (make-interval n1 n2)) 
        (b (make-interval n3 n4)))
    (check eql-interval?
           (mul-interval2 a b)
           (mul-interval a b))))

(define ex2.11-falsetru-tests
  (test-suite
    "Test for ex2.11-falsetru"

    (check-mul -10 -10 -10 -10)
    (check-mul -10 -10 -10   0)
    (check-mul -10 -10 -10  10)
    (check-mul -10 -10   0   0)
    (check-mul -10 -10   0  10)
    (check-mul -10 -10  10  10)

    (check-mul -10   0 -10 -10)
    (check-mul -10   0 -10   0)
    (check-mul -10   0 -10  10)
    (check-mul -10   0   0   0)
    (check-mul -10   0   0  10)
    (check-mul -10   0  10  10)

    (check-mul -10  10 -10 -10)
    (check-mul -10  10 -10   0)
    (check-mul -10  10 -10  10)
    (check-mul -10  10   0   0)
    (check-mul -10  10   0  10)
    (check-mul -10  10  10  10)

    (check-mul   0   0 -10 -10)
    (check-mul   0   0 -10   0)
    (check-mul   0   0 -10  10)
    (check-mul   0   0   0   0)
    (check-mul   0   0   0  10)
    (check-mul   0   0  10  10)

    (check-mul   0  10 -10 -10)
    (check-mul   0  10 -10   0)
    (check-mul   0  10 -10  10)
    (check-mul   0  10   0   0)
    (check-mul   0  10   0  10)
    (check-mul   0  10  10  10)

    (check-mul  10  10 -10 -10)
    (check-mul  10  10 -10   0)
    (check-mul  10  10 -10  10)
    (check-mul  10  10   0   0)
    (check-mul  10  10   0  10)
    (check-mul  10  10  10  10)
    ))

(exit
  (cond
    ((= (run-tests ex2.11-falsetru-tests) 0))
    (else 1)))
