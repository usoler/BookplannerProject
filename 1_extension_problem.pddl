(define (problem test1) (:domain planificador)
    (:objects
	    L0 L1 L2 L3 L4 L5 - libro
		M0 M1 M2 M3 M4 M5 - mes
	)
	(:init
	    (predecesor L1 L0)
		(predecesor L0 L5)
		
		(leer L0)
		(leer L1)
		(leer L2)
		(leer L5)
		
		(= (ordenDia M0) 0)
		(= (ordenDia M1) 1)
		(= (ordenDia M2) 2)
		(= (ordenDia M3) 3)
		(= (ordenDia M4) 4)
		(= (ordenDia M5) 5)
		
		(= (predecesoresAsignados L0) 0)
		(= (predecesoresAsignados L1) 0)
		(= (predecesoresAsignados L2) 0)
		(= (predecesoresAsignados L3) 0)
		(= (predecesoresAsignados L4) 0)
		(= (predecesoresAsignados L5) 0)
		
		(= (predecesores L0) 1)
		(= (predecesores L1) 0)
		(= (predecesores L2) 0)
		(= (predecesores L3) 0)
		(= (predecesores L4) 0)
		(= (predecesores L5) 1)
	)
	(:goal (and
	          (forall (?x - libro) 
			      (imply (leer ?x) (libroAsignado ?x)
				  )
			   )
			)
	)
)