;pij means Class i in Period j
;Class 1
(declare-const p11 Bool)
(declare-const p12 Bool)
(declare-const p13 Bool)
(declare-const p14 Bool)
;Class 2
(declare-const p21 Bool)
(declare-const p22 Bool)
(declare-const p23 Bool)
(declare-const p24 Bool)
;Class 3
(declare-const p31 Bool)
(declare-const p32 Bool)
(declare-const p33 Bool)
(declare-const p34 Bool)
;Class 4
(declare-const p41 Bool)
(declare-const p42 Bool)
(declare-const p43 Bool)
(declare-const p44 Bool)

;All Classes assigned a period
(assert (or p11 p12 p13 p14))
(assert (or p21 p22 p23 p24))
(assert (or p31 p32 p33 p34))
(assert (or p41 p42 p43 p44))

;no Class is assigned more than one period
;Class 1
(assert (and p11 (not (or p12 p13 p14))))
(assert (and p12 (not (or p11 p13 p14))))
(assert (and p13 (not (or p12 p11 p14))))
(assert (and p14 (not (or p12 p13 p11))))
;Class 2
(assert (and p21 (not (or p22 p23 p24))))
(assert (and p22 (not (or p21 p23 p24))))
(assert (and p23 (not (or p22 p21 p24))))
(assert (and p24 (not (or p22 p23 p21))))
;Class 3
(assert (and p31 (not (or p32 p33 p34))))
(assert (and p32 (not (or p31 p33 p34))))
(assert (and p33 (not (or p32 p31 p34))))
(assert (and p34 (not (or p32 p33 p31))))
;Class 4
(assert (and p41 (not (or p42 p43 p44))))
(assert (and p42 (not (or p41 p43 p44))))
(assert (and p43 (not (or p42 p41 p44))))
(assert (and p44 (not (or p42 p43 p41))))

;Class 4 does not occur at the same time as Class 2
(assert (not (or (and p41 p21) (and p42 p22) (and p43 p23) (and p44 p24))))

;Class 3 occurs before Class 4.
(assert (or (and p31 (or p42 p43 p44)) (and p32 (or p43 p44 )) (and p33 p44)))

;Class 1 directly precedes Class 2
(assert (or (and p11 p22) (and p12 p23) (and p13 p24)))

;Class 1 cannot be in period 4
(assert (not p14))

;Class 3 is at the same time as Class 1
(assert (or (and p11 p31) (and p12 p32) (and p13 p33) (and p14 p34)))

;Class 3 is not in the first period
(assert (not p31))

(check-sat)
(get-model)
;TODO: Add output explanation

(assert (not p44))

(check-sat)
;TODO: Add output explanation
