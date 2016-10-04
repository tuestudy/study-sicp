(load "ch4-query.scm")

(define (uniquely-asserted query frame-stream)
  (let ((result-stream (stream-flatmap
			(lambda (frame)
			  (qeval (car query) (singleton-stream frame)))
			frame-stream)))
    (display (car query))(newline)
    (display result-stream)(newline)
    (if (and (not (stream-null? result-stream))
	     (not (stream-null? (stream-car result-stream)))
	     (stream-null? (stream-cdr result-stream)))
	result-stream
	the-empty-stream)))
   
(put 'unique 'qeval uniquely-asserted)

(query-driver-loop)