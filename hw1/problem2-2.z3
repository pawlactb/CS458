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

;all vertices have a color
(assert (or v11 v12 v13))
(assert (or v21 v22 v23))
(assert (or v31 v32 v33))
(assert (or v41 v42 v43))

;vertex 1 is connected to vertices 2, 3, and 4
(assert (=> v11 (not (or v21 v31 v41))))
(assert (=> v12 (not (or v22 v32 v42))))
(assert (=> v13 (not (or v23 v33 v43))))

;vertex 2 is connected to vertices 1, 3, and 4
(assert (=> v21 (not (or v11 v31 v41))))
(assert (=> v22 (not (or v12 v32 v42))))
(assert (=> v23 (not (or v13 v33 v43))))

;vertex 3 is connected to vertices 1, 2, and 4
(assert (=> v31 (not (or v11 v21 v41))))
(assert (=> v32 (not (or v12 v22 v42))))
(assert (=> v33 (not (or v13 v23 v43))))

;vertex 4 is connected to vertices 1, 2, and 3
(assert (=> v41 (not (or v11 v21 v31))))
(assert (=> v42 (not (or v12 v22 v32))))
(assert (=> v43 (not (or v13 v23 v33))))

(check-sat)
(get-model)

; The model is not satisfiable, suggesting there is no way to color this graph with 3 colors
