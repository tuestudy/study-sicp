(load "ex2.68-Solidone.ss")
(load "ex2.69-Solidone.ss")

(define pairs '((A 2) (BOOM 1) (GET 2) (JOB 2) (NA 16) (SHA 3) (YIP 9) (WAH 1)))

(define rock-huff-tree (generate-huffman-tree pairs))

(define text '(GET A JOB SHA NA NA NA NA NA NA NA NA GET A JOB SHA NA NA NA NA NA NA NA NA WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP SHA BOOM))

(define result '(1 1 1 1 1 1 1 0 0 1 1 1 1 0 1 1 1 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 0 1 1 1 1 0 1 1 1 0 0 0 0 0 0 0 0 0 1 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 1 1))

; test-case
(equal?
 result
 (encode text rock-huff-tree))
; huffman-encoding ; 84
(equal? (decode result rock-huff-tree) text) 
(length (encode text rock-huff-tree))

; fix-bit-encoding ; 108
(* (length text) (/ (log (expt 2 3)) (log 2)))

; huffman-encoding save 24 bits!

