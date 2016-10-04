; 2.20 revisited

(define (same-parity x . y)
  (define (moamoa condition list)
    (if (null? list)
        '()
        (if (condition (car list))
            (cons (car list) (moamoa condition (cdr list)))
            (moamoa condition (cdr list)))))
  (let ((theparity (remainder x 2)))
    (cons x (moamoa (lambda (x) (= (remainder x 2) theparity)) y))))


(same-parity 2 3 4 5 6 7 8 9 10)

; 잠깐 꼬리점 문법이 생각안나서 들춰봤다가 다시 풀어봄.
; 이왕 푼 김에 업로드!!
           