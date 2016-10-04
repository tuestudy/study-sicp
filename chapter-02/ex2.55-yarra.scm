; 2.55

(car ''abracadabra)

(eq? 'abracadabra (quote abracadabra))

(car (quote (quote abracadabra)))

(eq? 'abracadabra (quote abracadabra))


; 'symbol 은 (quote symbol) 의 syntax sugar 인 듯.
; ''abracadabra 는 (quote (quote abracadabra)) 로 평가 되고,
; 다시 (quote abracadabra) 라는 리스트로 평가 되므로,
; (car ''abracadabra) 는 (car (quote abracadabra) 이니까.
; quote 가 된다.

