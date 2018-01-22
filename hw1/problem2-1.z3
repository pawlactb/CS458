;Vertices
;vij = vertex i, color j
(declare-const v11 Bool)
(declare-const v12 Bool)
(declare-const v13 Bool)

(declare-const v21 Bool)
(declare-const v22 Bool)
(declare-const v23 Bool)

(declare-const v31 Bool)
(declare-const v32 Bool)
(declare-const v33 Bool)

(declare-const v41 Bool)
(declare-const v42 Bool)
(declare-const v43 Bool)

(declare-const v51 Bool)
(declare-const v52 Bool)
(declare-const v53 Bool)

(declare-const v61 Bool)
(declare-const v62 Bool)
(declare-const v63 Bool)

;all vertices have a color
(assert (or v11 v12 v13))
(assert (or v21 v22 v23))
(assert (or v31 v32 v33))
(assert (or v41 v42 v43))
(assert (or v51 v52 v53))
(assert (or v61 v62 v63))

;vertex 1 is connected to vertices 2 and 3
(assert (=> v11 (not (or v21 v31))))
(assert (=> v12 (not (or v22 v32))))
(assert (=> v13 (not (or v23 v33))))

;vertex 2 is connected to vertices 1, 3, 4, and 5
(assert (=> v21 (not (or v11 v31 v41 v51))))
(assert (=> v22 (not (or v12 v32 v42 v52))))
(assert (=> v23 (not (or v13 v33 v43 v53))))

;vertex 3 is connected to vertices 1, 2, 5, and 6
(assert (=> v31 (not (or v11 v21 v51 v61))))
(assert (=> v32 (not (or v12 v22 v52 v62))))
(assert (=> v33 (not (or v13 v23 v53 v63))))

;vertex 4 is connected to vertices 2 and 5
(assert (=> v41 (not (or v21 v51))))
(assert (=> v42 (not (or v22 v52))))
(assert (=> v43 (not (or v23 v53))))

;vertex 5 is conencted to vertices 2, 3, 4, and 6
(assert (=> v51 (not (or v21 v31 v41 v61))))
(assert (=> v52 (not (or v22 v32 v42 v62))))
(assert (=> v53 (not (or v23 v33 v43 v63))))

;vertex 6 is connected to vertices 3 and 5
(assert (=> v61 (not (or v31 v51))))
(assert (=> v62 (not (or v32 v52))))
(assert (=> v63 (not (or v33 v53))))

(check-sat)
(get-model)

; The model is satisfiable, suggesting the following color scheme
; Color 1: vertices 3 and 4
; Color 2: vertices 1 and 5
; Color 3: vertices 2 and 6
