(define (problem test) (:domain basic_planner)
   (:objects L0 L1 L2 L3 L4 L5 - libro)
	(:init
		(predecesor L4 L1)

		(leer L0)
		(leer L2)
		(leer L4)
		(leer L5)

		(leido L3)

	)
		(:goal (and
			(forall (?x - libro)
				(not (leer ?x))
			)
		)
	)
)