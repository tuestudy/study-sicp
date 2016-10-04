;; 허프만 트리.

; 잎의 구조      ('leaf 글자 무게)
; 트리의 구조    (왼쪽가지 오른쪽가지 심볼리스트 총무게)

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? object)
  (eq? (car object) 'leaf))

(define (symbol-leaf x) (cadr x))

(define (weight-leaf x) (caddr x))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch tree) (car tree))

(define (right-branch tree) (cadr tree))

(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch
               (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit -- CHOOSE-BRANCH" bit))))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)
                               (cdr pair))
                    (make-leaf-set (cdr pairs))))))

; 2.68

; encode 프로시저는 글과 나무를 인자로 받아서, 그 글을 인코딩한 비트 리스트를 내놓는다.


(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))



(define (encode-symbol char tree)
  (define (hasit? char list)
    (if (null? list)
        #f
        (if (equal? (car list) char)
            #t
            (hasit? char (cdr list)))))
  (if (and (leaf? tree) (eq? char (cadr tree)))
      '()
      (if (hasit? char (caddr tree))
          (if (hasit? char (symbols (car tree)))
              (cons 0 (encode-symbol char (car tree)))
              (cons 1 (encode-symbol char (cadr tree))))
          (error "글자없거든!!"))))


;; 2.69

; 다음 프로시저는 (서로 다른 두 쌍 속에 같은 글자가 들어있지 않도록) 글자 빈도 쌍으로 이루어진
; 리스트를 인자로 받아서 허프만 알고리즘에 따라 인코딩 나무를 만들어 낸다.

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

; make-leaf-set 는 쌍 리스트를 인자로 받아서, 차례 매긴 나뭇잎 집합으로 바꿔 주는 프로시저인데,
; 이것은 본문에서 정의한 것과 같다. make-code-tree프로저를 써서, 집합에 원소 하나만 남을 때까지,
; 곧 허프만 나무를 만들 때까지 가장 가벼운 두 원소를 잇달아 묶어내는 successive-merge 프로시저를 짜라.
; (이 프로시저를 짜려면 조금 잔재주를 부려야 하지만, 복잡한 것은 아니다. 따라서 복잡한 프로시저
; 를 설계한다면, 뭔가 잘못하고 있다고 보면 틀림없다. 이때, 차례매긴 집합 표현 방식을 쓴다는 사실에서
; 큰 도움을 얻을 수 있다.

; 잎의 구조      ('leaf 글자 무게)
; 트리의 구조    (왼쪽가지 오른쪽가지 심볼리스트 총무게)


(define (successive-merge pairs)
  (if (= (length pairs) 1)
      (car pairs)
      (successive-merge (adjoin-set (make-code-tree (car pairs) (cadr pairs)) (cddr pairs)))))

;test
(define rawpair (list
                 (cons 'a '8)
                 (cons 'b '3)
                 (cons 'c '1)
                 (cons 'd '1)
                 (cons 'e '1)
                 (cons 'f '1)
                 (cons 'g '1)
                 (cons 'h '1)))


(generate-huffman-tree rawpair)



