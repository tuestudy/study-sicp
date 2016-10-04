(load "comkid-simulator.scm")

(define ambiguous-machine
  (make-machine
   '(a)
   '()
   '(start
     (goto (label here))
     here
     (assign a (const 3))
     (goto (label there))
     here
     (assign a (const 4))
     (goto (label there))
     there)))

(set-register-contents! ambiguous-machine 'a 1)
(start ambiguous-machine)
(get-register-contents ambiguous-machine 'a)

