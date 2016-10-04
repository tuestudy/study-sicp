(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex3.23-falsetru.scm")

(define ex3.23-falsetru-tests
  (test-suite
   "Test for ex3.23-falsetru"

   (test-case "node manipulation"
    (define n (make-node 'a null null))
    (check-equal? (prev-node n) null)
    (check-equal? (next-node n) null)
    (set-prev-node! n (make-node 'b null null))
    (set-next-node! n (make-node 'c null null))
    (check-equal? (next-node (prev-node n)) n)
    (check-equal? (prev-node (prev-node n)) null)
    (check-equal? (prev-node (next-node n)) n)
    (check-equal? (next-node (next-node n)) null)
    (check-equal? (print-node (prev-node n)) '(b a c))
    )
   (test-case "set-{prev|next}-node! with null"
    (define n (make-node 'a null null))
    (set-next-node! n null)
    (set-prev-node! n null)
    (check-equal? (print-node n) '(a))
    )

   (test-case
    "queue"
    (define empty-q (make-deque))
    (define q (make-deque))

    ; front-insert-deque!, rear-insert-deque!, print-deque
    (front-insert-deque! q 'a)
    (front-insert-deque! q 'b)
    (rear-insert-deque! q 'c)
    (check-equal? (print-deque q) '(b a c))

    ; empty-deque?
    (check-true (empty-deque? empty-q))
    (check-false (empty-deque? q))

    ; front-deque, rear-deque
    (check-exn exn? (lambda () (front-deque empty-q)))
    (check-exn exn? (lambda () (rear-deque empty-q)))
    (check-equal? (front-deque q) 'b)
    (check-equal? (rear-deque q) 'c)

    ; front-delete-deque!, rear-delete-deque!
    (check-exn exn? (lambda () (front-delete-queue! empty-q)))
    (check-exn exn? (lambda () (rear-delete-queue! empty-q)))

    (front-delete-deque! q)
    (check-equal? (print-deque q) '(a c))
    (rear-delete-deque! q)
    (check-equal? (print-deque q) '(a))
    (rear-delete-deque! q)
    (check-equal? (print-deque q) null)
    (check-true (empty-deque? q))
    )
   ))

(exit
  (cond
    ((= (run-tests ex3.23-falsetru-tests) 0))
    (else 1)))
