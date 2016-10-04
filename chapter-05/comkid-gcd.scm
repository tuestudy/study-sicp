(load "comkid-simulator.scm")

(eq? 'done (set-register-contents! gcd-machine 'a 206))
(eq? 'done (set-register-contents! gcd-machine 'b 40))
(eq? 'done (start gcd-machine))
(eq? 2 (get-register-contents gcd-machine 'a))
