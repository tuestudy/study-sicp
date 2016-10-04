;; The first three lines of this file were inserted by DrScheme. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex1.03-hayarobee) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(define (assert a b) (= a b))

(define (get-minimum a b c)
  (cond ((and (< a b) (< a c)) a)
       ((and (< c a) (< c b)) c)
       (else b)))

(define (sum-square a b c)
  (+ (square a) (square b) (square c)))

(define (square a) (* a a))

(define (sum-square-except-minimum a b c)
  (- (sum-square a b c) (square (get-minimum a b c))))


"Test Code"
"SVN Client Example"
(and
 (assert (get-minimum 1 2 3) 1)
 (assert (sum-square 1 2 3) 14)
 (assert (sum-square-except-minimum 1 2 3) 13)
 (assert (sum-square-except-minimum 4 6 9) 117)
)
