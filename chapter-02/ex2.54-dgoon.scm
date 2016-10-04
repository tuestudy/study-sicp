(load "../misc/scheme-test.scm")

(define (my-equal? a b)
  (cond ((and (null? a) (not (null? b))) #f)
	((and (not (null? a)) (null? b)) #f)
	((and (null? a) (null? b)) #t)
	((eq? (car a) (car b)) (my-equal? (cdr a) (cdr b)))
	(else #f)))

(define (xor a b) (or (and (not a) b) (and a (not b))))

(define (my-equal2? a b)
  (cond ((xor (null? a) (null? b)) #f)
	((and (null? a) (null? b)) #t)
	((eq? (car a) (car b)) (my-equal2? (cdr a) (cdr b)))
	(else #f)))

(run
 (make-testcase
  '(assert-true? (my-equal? '(i am a girl) '(i am a girl)))
  '(assert-false? (my-equal? '(i am a boy) '(i (am a) boy)))
  '(assert-true? (my-equal2? '(i am a girl) '(i am a girl)))
  '(assert-false? (my-equal2? '(i am a boy) '(i (am a) boy)))))

