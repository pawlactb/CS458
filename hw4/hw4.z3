(set-option :produce-unsat-cores true)

(declare-sort Person)
; M(x, y) is true if x is y's mother 
(declare-fun M (Person Person) bool)

;question 1
(push)
; Somebody has a mother
(assert (! (forall ((x Person)) (exists ((y Person)) (M x y) )) :named somemom))

; Everyone has a mother who is not themselves
(assert (! (forall ((x Person)) (exists ((y Person)) (=> (M x y) (not (= x y))))) :named notownmom))

; Nobody can have two mothers
(assert (! (forall ((x Person) (y Person)) (=> (M x y) (exists ((z Person)) (and (not (M x z)) (not (= y z))))))  :named onemom))

; Someone has at least two children
(assert (! (exists ((x Person) (y Person) (z Person)) (and (M x y) (M x z))) :named twochildren))

(check-sat)
(get-model)
(pop)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Question 2
(push)
(declare-fun age (Person) Int)

; Somebody has a mother
(assert (! (exists ((x Person)) (exists ((y Person)) (M x y) )) :named somemom))

; Nobody can have two mothers
(assert (! (forall ((x Person) (y Person)) (=> (M x y) (exists ((z Person)) (and (not (M x z)) (not (= y z))))))  :named onemom))

; Your mom is older than you
(assert (! (forall ((x Person) (y Person)) (=> (M x y) (> (age x) (age y)))) :named oldmom))

; Everyone has a mother except for possibly ann
(assert (! (forall ((x Person)) (exists ((y Person)) (M x y) )) :named everymom))

; Someone has at least two children
(assert (! (exists ((x Person) (y Person) (z Person)) (and (M x y) (M x z))) :named twochildren))

; Age is positive
(assert (! (forall ((x Person)) (> (age x) 0)) :named posage))

(check-sat)
(get-model)
(pop)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
