(define (domain planificador)
    (:requirements :adl :typing)
	(:types libro - item)
	(:predicates
	    (predecesor ?x - libro ?y - libro) ;; 'x' es predecesor de 'y'
		(leer ?x - libro)                  ;; libro 'x' disponible para leer
	)
	
	(:action ver_predecesor 
	    :parameters (?x - libro ?y - libro)
	    :precondition (and 
		                 (predecesor ?x ?y)
						 (leer ?y)
					  )
		:effect (leer ?x)
	)
)