(define (domain planificador)
    (:requirements :adl :typing :fluents)
	(:types
	    libro - item
		mes - item)
	(:functions
	    (predecesores ?x - libro)
		(predecesoresAsignados ?x - libro)
		(ordenMes ?m - mes))
		
	(:predicates
	    (predecesor ?x - libro ?y - libro) ;; 'x' es predecesor de 'y'
		(leer ?x - libro)                  ;; libro 'x' disponible para leer
		(libroAsignado ?x - libro))        ;; libro 'x' ya asignado a un mes concreto
	
	(:action ver_predecesor 
	    :parameters (?x - libro ?y - libro)
	    :precondition (and 
		                 (predecesor ?x ?y)
						 (leer ?y)
					  )
		:effect (leer ?x))
	
	(:action asignar_libros
	    :parameters (?m - mes ?x - libro)
		:precondition (and
		                 (leer ?x)
						 (not (libroAsignado ?x))
						 (= (predecesores ?x) (predecesoresAsignados ?x))
		              )
		:effect (forall (?y - libro) (when (predecesor ?x ?y)
		            (increase (predecesoresAsignados ?y) 1))))
)