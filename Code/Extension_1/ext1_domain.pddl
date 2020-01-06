;; Extensión 1:
;; 
;; Los libros pueden tener de 0 a N predecesores pero ningún paralelo.
;;
;; El planner es capaz de construir un plan para poder llegar a leer los libros 
;; objetivo, donde para todo libro que pertenece al plan, todos sus libros predecesores
;; pertenecen al plan y están en meses anteriores.
;;
(define (domain ext1_planner)
    (:requirements :strips :typing :adl :fluents)
    (:types libro - object
            mes - object
    )
    (:functions
        (numero_mes ?m - mes)     ;; numero del mes
        (ultimo_mes ?x - libro)   ;; ultimo mes asignado a un predecesor de "x"
    )
    (:predicates
        (predecesor ?x - libro ?y - libro)   ;; "x" es predecesor de "y"
        (leer ?x - libro)                    ;; "x" es un libro que quiere leer
        (leido ?x - libro)                   ;; "x" es un libro ya leido
        (asignado ?x - libro)                ;; "x" es un libro ya asignado a un mes
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

    (:action asignar_libro_predecesor
        :parameters (?x - libro ?m - mes)
        :precondition (and
                          (leer ?x)
                          (not(asignado ?x))
                          (> (numero_mes ?m) (ultimo_mes ?x))
                          (forall (?y - libro)
                              (or
                                  (not (predecesor ?y ?x))
                                  (leido ?y)
                              )
                          )
                      )
        :effect (and
                    (asignado ?x)
                    (not (leer ?x))
                    (leido ?x)
                    (forall (?y - libro)
                        (when (predecesor ?x ?y)
                            (and
                                (assign (ultimo_mes ?y) (numero_mes ?m))
                            )
                        )
                    )
                )
    )
)