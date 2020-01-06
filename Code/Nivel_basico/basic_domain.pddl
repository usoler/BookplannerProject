;; Nivel básico:
;;
;; En el plan de lectura todos los libros tienen 0 o 1 predecesores
;; y ningún paralelo.
;;
;; El planner es capaz de encontrar un plan para poder llegar a leer los libros
;; objetivo encadenando libros, donde cada libro tiene solo uno o ningún predecesor.
;;
(define (domain basic_planner)
    (:requirements :strips :typing :adl)
    (:types libro - object)
    (:predicates
        (predecesor ?x - libro ?y - libro)   ;; "x" es predecesor de "y"
        (leer ?x - libro)                    ;; "x" es un libro que quiere leer
        (leido ?x - libro)                   ;; "x" es un libro ya leido
    )

    (:action anyadir_libro_predecesor_a_leer
        :parameters (?x - libro ?y - libro)
        :precondition (and
                           (predecesor ?x ?y)
                           (leer ?y)
                           (not (leido ?x))
                       )
        :effect (leer ?x)
    )

    (:action leer_libro
        :parameters (?x - libro)
        :precondition (and
                           (leer ?x)
                           (forall (?y - libro) 
                               (or
                                   (not (predecesor ?y ?x))
                                   (leido ?y)
                               )
                           )
                       )
        :effect (and 
                    (not (leer ?x))
                    (leido ?x)
                )
    )
)