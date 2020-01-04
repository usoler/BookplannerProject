(define (problem test) (:domain planificador)
    (:objects L1 L2 L3 L4 L5 - libro)
	(:init
	    (predecesor L1 L2)
		(predecesor L2 L3)
		(predecesor L4 L5)
		
		(leer L3)
		(leer L5)
	)
	(:goal (and
	          (forall (?x - libro) 
			      (leer ?x)
			   )
			)
	)
)