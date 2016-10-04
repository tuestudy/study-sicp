(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex3.22-falsetru.scm")

(define ex3.22-falsetru-tests
  (test-suite
   "Test for ex3.22-falsetru"

   (test-case
    "queue"
    (define empty-q (make-queue))
    (define q (make-queue))
    (insert-queue! q 'a)
    (insert-queue! q 'b)
    (insert-queue! q 'c)

    (check-true (empty-queue? empty-q))
    (check-false (empty-queue? q))

    (check-exn exn? (lambda () (front-queue empty-q)))
    (check-exn exn? (lambda () (delete-queue! empty-q)))

    (check-equal? (front-queue q) 'a)
    (delete-queue! q)
    (check-equal? (front-queue q) 'b)
    (delete-queue! q)
    (check-equal? (front-queue q) 'c)
    (check-exn exn? (lambda () (delete-queue! empty-q)))
    )

   ))

(exit
  (cond
    ((= (run-tests ex3.22-falsetru-tests) 0))
    (else 1)))
