;; Nivel básico:
;;
;; En el plan de lectura todos los libros tienen 0 o 1 predecesores
;; y ningún paralelo.
;;
;; El planner es capaz de encontrar un plan para poder llegar a leer los libros
;; objetivo encadenando libros, donde cada libro tiene solo uno o ningún predecesor.
;;
(define (problem basic_test) (:domain basic_planner)
    (:objects L1 L2 L3 L4 L5 L6 - libro)
    (:init
        (predecesor L1 L2)
        (predecesor L5 L6)

        (leido L4)
        (leido L5)
        
        (leer L2)
        (leer L3)
        (leer L6)
    )

    (:goal (and 
               (forall (?x - libro) 
                   (not (leer ?x))
               )
           )
    )
)