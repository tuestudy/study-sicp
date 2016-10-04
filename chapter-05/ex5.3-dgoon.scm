(controller
 (assign x (op read))
 sqrt
 (assign g (const 1.0))
 good-enough?
 (assign h (op *) (reg g) (reg g))
 (assign i (op -) (reg x) (reg h))
 (assign j (op abs) (reg i))
 (test (op <) (reg j) (const 0.001))
 (branch (label done))
 improve
 (assign h (op /) (reg x) (reg g))
 (assign i (op +) (reg h) (reg g))
 (assign j (op /) (reg i) (const 2.0))
 (assign g (reg j))
 (goto (label good-enough?))
 done)
