; a
; f에 파일타입 정보가 있어야 함
(define (get-record empname f)
  ((get (file-type f) 'get-record) empname f))

; b
; emp에 파일타입 정보가 있어야 함
(define (get-salary emp)
  ((get (file-type f) 'get-salary) emp))

; c
(define (find-employee-record empname files)
  (if (null? files) null
    (let ((result (get-record empname files)))
      (if (null? result)
        (find-employee-record empname (cdr files))
        result))))

; d
; (put 'new-division 'get-record ...) 따위가 필요하다.
