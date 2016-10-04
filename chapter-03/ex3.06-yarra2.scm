(define (rand-update x)
  (remainder (+ (* 7 x) 19) 997))

(define rand
  (let ((x 0))
    (lambda (sym)
      (cond ((eq? sym 'generate)
             (begin (set! x (rand-update x)) x))
            ((eq? sym 'reset)
             (lambda (value) (set! x value)))))))
          

(rand 'generate)
(rand 'generate)
(rand 'generate)
(rand 'generate)
((rand 'reset) 86)
(rand 'generate)
(rand 'generate)
(rand 'generate)
(rand 'generate)




    
    
    