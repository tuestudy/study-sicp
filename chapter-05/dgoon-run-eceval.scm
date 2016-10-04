;;;; LOADS THE EXPLICIT-CONTROL EVALUATOR FROM SECTION 5.4 OF
;;;; STRUCTURE AND INTERPRETATION OF COMPUTER PROGRAMS, WITH
;;;; ALL THE SUPPORTING CODE IT NEEDS IN ORDER TO RUN.

;;;; **NB** The actual "load" calls are implementation dependent.

;(load "ch5-regsim.scm")			;reg machine simulator ; This is downloaded code
;(load "dgoon-simulator.scm")        ; dgoon did it. use it instead of the downloaded
(load "dgoon-simulator.scm")        ; dgoon did it. use it instead of the downloaded

;; **NB** next file contains another "load"
(load "ch5-eceval-support.scm")		;simulation of machine operations
;(load "ex5.23-dgoon.scm")			;eceval itself
(load "ex5.26-dgoon-eceval.scm")

;; start driver loop
(define the-global-environment (setup-environment))
(start eceval)
