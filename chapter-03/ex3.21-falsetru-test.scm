(load "ex3.21-falsetru.scm")

(define q1 (make-queue))
(insert-queue! q1 'a)
(insert-queue! q1 'b)
(print-queue q1)
(newline)
(delete-queue! q1)
(print-queue q1)
(newline)
(delete-queue! q1)
(print-queue q1)
(newline)
