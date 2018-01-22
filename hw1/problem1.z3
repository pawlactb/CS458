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
(assert (=> p11 (not (or p12 p13 p14))))
(assert (=> p12 (not (or p11 p13 p14))))
(assert (=> p13 (not (or p12 p11 p14))))
(assert (=> p14 (not (or p12 p13 p11))))
;Class 2
(assert (=> p21 (not (or p22 p23 p24))))
(assert (=> p22 (not (or p21 p23 p24))))
(assert (=> p23 (not (or p22 p21 p24))))
(assert (=> p24 (not (or p22 p23 p21))))
;Class 3
(assert (=> p31 (not (or p32 p33 p34))))
(assert (=> p32 (not (or p31 p33 p34))))
(assert (=> p33 (not (or p32 p31 p34))))
(assert (=> p34 (not (or p32 p33 p31))))
;Class 4
(assert (=> p41 (not (or p42 p43 p44))))
(assert (=> p42 (not (or p41 p43 p44))))
(assert (=> p43 (not (or p42 p41 p44))))
(assert (=> p44 (not (or p42 p43 p41))))

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
; The scheduling problem is solved by having courses as follows:
; Class 1: Period 2
; Class 2: Period 3
; Class 3: Period 2
; Class 4: Period 4

(assert (not p44))

(check-sat)
; By stipulating that Class 4 is in period 4, there is no schedule that fits our criteria.
