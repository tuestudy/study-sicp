(load "ex2.68-Solidone.ss")
(load "ex2.69-Solidone.ss")

; n = 5, (1 2 4 8 16)
(define pairs1 (list (list 'A 16) (list 'B 8) (list 'C 4) (list 'D 2) (list 'E 1)))

(length (encode-symbol 'A (generate-huffman-tree pairs1)))
(length (encode-symbol 'E (generate-huffman-tree pairs1)))

; n = 10, (1 2 4 8 16 32 64 128 256 512)
(define pairs2 (list (list 'A 512) (list 'B 256) (list 'C 128) (list 'D 64) (list 'E 32) (list 'F 16) (list 'G 8) (list 'H 4) (list 'I 2) (list 'J 1)))

(length (encode-symbol 'A (generate-huffman-tree pairs2)))
(length (encode-symbol 'J (generate-huffman-tree pairs2)))

;max_weight is 1 bit, min_weight is n-1 bit.

