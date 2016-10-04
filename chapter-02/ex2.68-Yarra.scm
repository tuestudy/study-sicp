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
                               (cadr pair))
                    (make-leaf-set (cdr pairs))))))

; 2.68

; encode 프로시저는 글과 나무를 인자로 받아서, 그 글을 인코딩한 비트 리스트를 내놓는다.


(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

; 인코딩 나무를 보고, 한 글자를 인코딩하여 비트 리스트를 내놓도록
; encode-symbol 프로시저를 짜라. 그 글자가 나무에 없을 때에는 잘못되었음을 알려주도록
; 프로시저를 설계해야 한다. 이 프로시저가 올바로 돌아가는지 알아보기 위하여,
; 연습문제 2.67 에서 sample-tree 로 얻어낸 결과를 인코딩하여, 그 결과가 처음 글과
; 같은지 살펴보라.

; 잎의 구조      ('leaf 글자 무게)
; 트리의 구조    (왼쪽가지 오른쪽가지 심볼리스트 총무게)

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

;test
(equal? sample-message (encode (decode sample-message sample-tree) sample-tree))