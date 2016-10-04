(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.29-falsetru.scm")

(define banana (make-branch 2 10))
(define cat (make-branch 10 30))
(define dog (make-branch 12 40))
(define m-left (make-mobile banana cat))
(define b-left (make-branch 2 m-left))
(define mobile (make-mobile dog b-left))

(define ex2.29-falsetru-tests
  (test-suite
   "Test for ex2.29"

   (test-case "a: selector"
    (check-equal? (branch-length cat) 10)
    (check-equal? (branch-structure cat) 30)
    (check-equal? (left-branch mobile) dog)
    (check-equal? (right-branch mobile) b-left))

   (test-case "b: total-weight"
    (check-false (is-mobile? (branch-structure dog)))
    (check-false (is-mobile? (branch-structure cat)))
    (check-true (is-mobile? (branch-structure b-left)))
    (check-equal? (branch-weight cat) 30)
    (check-equal? (branch-weight b-left) 40)
    (check-equal? (total-weight mobile) 80))

   (test-case "c: balanced?"
    (define b-left-2 (make-branch 12 m-left))
    (define mobile-2 (make-mobile dog b-left-2))

    (define dog-2 (make-branch 12 20))
    (define dog-3 (make-branch 12 20))
    (define dog-m (make-mobile dog-2 dog-3))
    (define dog-b (make-branch 12 dog-m))
    (define mobile-3 (make-mobile dog dog-b))

    (check-equal? (torque dog) (* 12 40))
    (check-equal? (torque b-left) (* 2 40))

    (check-true (branch-balanced? dog))
    (check-false (branch-balanced? b-left-2))
    (check-true (branch-balanced? dog-b))

    (check-false (balanced? mobile))
    (check-false (balanced? mobile-2))
    (check-true (balanced? dog-m))
    (check-true (balanced? mobile-3)))

   (test-case "d: list -> cons"
    ; XXX
    (check-false (pair? (branch-structure dog))))
   ))

(exit
  (cond
    ((= (run-tests ex2.29-falsetru-tests) 0))
    (else 1)))
