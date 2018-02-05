;Class example used as example, worked independently.


; The people are adam, audrey, cynthia and kassandra
(declare-datatypes () ((name adam audrey cynthia kassandra)))

; The cameras are canon, casio, kodak and polaroid
(declare-datatypes () ((camera canon casio kodak polaroid)))

; The Internet Browsers are Firefox, Internet Explorer, Opera, and Safari
(declare-datatypes () ((browser ff ie opera safari)))

; cam maps each person to the camera they have 
(declare-fun cam (name) camera)

; brow maps each person to their web browser
(declare-fun brow (name) browser)

; mp maps each person to their camera's megapixels
; 1 = 1.8, 2 = 3.2, 3 = 4.0, 4 = 7.0
(declare-fun mp (name) Int)
(assert (and (>= (mp adam) 1) (<= (mp adam) 4)))
(assert (and (>= (mp audrey) 1) (<= (mp audrey) 4)))
(assert (and (>= (mp cynthia) 1) (<= (mp cynthia) 4)))
(assert (and (>= (mp kassandra) 1) (<= (mp kassandra) 4)))

;caminv is the inverse of cam, browinv is the inverse of brow, mpinv is the inverse of mp
(declare-fun caminv (camera) name)
(declare-fun browinv (browser) name)
(declare-fun mpinv (Int) name)

; This defines that explicitly that those functions are inverses
; This is the only place I wish I could use quantifiers
(assert (= (caminv (cam audrey)) audrey))
(assert (= (caminv (cam adam)) adam))
(assert (= (caminv (cam cynthia)) cynthia))
(assert (= (caminv (cam kassandra)) kassandra))

(assert (= (browinv (brow audrey)) audrey))
(assert (= (browinv (brow adam)) adam))
(assert (= (browinv (brow cynthia)) cynthia))
(assert (= (browinv (brow kassandra)) kassandra))

(assert (= (mpinv (mp audrey)) audrey))
(assert (= (mpinv (mp adam)) adam))
(assert (= (mpinv (mp cynthia)) cynthia))
(assert (= (mpinv (mp kassandra)) kassandra))

; 1.) Of audrey and the photographer with the canon camera, one only uses safari. the other has the 4.0 megapixel camera
(assert (xor (and (= (brow audrey) safari) (= (mp (caminv canon)) 3))
             (and (= (brow (mpinv 3)) safari) (= (mp audrey) 3))))
             
; 2.) Cynthia has the kodak camera
(assert (= (cam cynthia) kodak))

; 3.) the person with a 4.0 mp camera can't stand internet explorer
(assert (not (= (brow (mpinv 3)) ie)))

; 4.) the person who prefers internet explorer has a camera with more megapixels than the photographer with the polaroid
(assert (> (mp (browinv ie)) (mp (caminv polaroid))))

; 5.) either the photographer with the kodak camera or the photographer with the polaroid camera only uses firefox for their websurfing
(assert (xor (= (brow (caminv kodak)) ff) (= (brow (caminv polaroid)) ff)))

; 6.) the person with 1.8 megapixels is cynthia
(assert (= (mp cynthia) 1))

; 7.) the person who prefers using ie is not kassandra
(assert (not (= (browinv ie) kassandra)))

; 8.) the person using safari is audrey
(assert (= (brow audrey) safari))

; 9.) the person with the canon has more megapixels than audrey
(assert (> (mp (caminv canon)) (mp audrey)))

(check-sat)
(get-model)

;the model is satisfiable.
;solution interpretation:
; person    camera   web browser         megapixels
; --------------------------------------------------
; audrey    casio    safari              4.0 MP
; cynthia   kodak    opera               1.8 MP
; kassandra polaroid firefox             3.2 MP
; adam      canon    internet explorer   7.0 MP
