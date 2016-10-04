(load "ex2.47-Solidone.ss")
(load "ex2.48-Solidone.ss")

;from text
(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
        ((frame-coord-map frame) (start-segment segment))
        ((frame-coord-map frame) (end-segment segment))))
     segment-list)))

;answer
(define (draw-edges)
  (segments->painter
   (list (make-segment (make-vect 0 0) (make-vect 0 1))
         (make-segment (make-vect 0 1) (make-vect 1 1))
         (make-segment (make-vect 1 1) (make-vect 1 0))
         (make-segment (make-vect 1 0) (make-vect 0 0)))))

(define (draw-cross)
  (segments->painter
   (list (make-segment (make-vect 0 0) (make-vect 1 1))
         (make-segment (make-vect 1 0) (make-vect 0 1)))))

(define (draw-diamond)
  (segments->painter
   (list (make-segment (make-vect 0.5 0) (make-vect 0 0.5))
         (make-segment (make-vect 0 0.5) (make-vect 0.5 1))
         (make-segment (make-vect 0.5 1) (make-vect 1 0.5))
         (make-segment (make-vect 1 0.5) (make-vect 0.5 0)))))

(define (draw-wave)
  (segments->painter
   (list (make-segment (make-vect 0.2 0) (make-vect 0.35 0.5))
         (make-segment (make-vect 0.35 0.5) (make-vect 0.3 0.55))
         (make-segment (make-vect 0.3 0.55) (make-vect 0.2 0.4)) 
         (make-segment (make-vect 0.2 0.4) (make-vect 0 0.6)) 
         (make-segment (make-vect 0 0.8) (make-vect 0.2 0.55)) 
         (make-segment (make-vect 0.2 0.55) (make-vect 0.3 0.7)) 
         (make-segment (make-vect 0.3 0.7) (make-vect 0.4 0.7)) 
         (make-segment (make-vect 0.4 0.7) (make-vect 0.35 0.85)) 
         (make-segment (make-vect 0.35 0.85) (make-vect 0.4 1)) 
         (make-segment (make-vect 0.6 1) (make-vect 0.65 0.85)) 
         (make-segment (make-vect 0.65 0.85) (make-vect 0.6 0.7))
         (make-segment (make-vect 0.6 0.7) (make-vect 0.8 0.7)) 
         (make-segment (make-vect 0.8 0.7) (make-vect 1 0.4)) 
         (make-segment (make-vect 1 0.2) (make-vect 0.6 0.5))
         (make-segment (make-vect 0.6 0.5) (make-vect 0.7 0)) 
         (make-segment (make-vect 0.35 0) (make-vect 0.45 0.35)) 
         (make-segment (make-vect 0.45 0.35) (make-vect 0.55 0)) 
    )))

          