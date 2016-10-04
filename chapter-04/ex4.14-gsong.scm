(define (eval-map exp env)
  (mymap (myeval (cadr exp) env) (myeval (caddr exp) env)))

(define (mymap proc arglist)
  (if (null? arglist) '()
      (cons (myapply proc (list (car arglist))) (mymap proc (cdr arglist)))))

(put 'map 'eval eval-map)