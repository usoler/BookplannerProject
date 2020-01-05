;; Extensión 2: 
;;
;; Extensión 1 + los libros pueden tener de 0 a M libros paralelos. 
;;
;; El planner es capaz de construir un plan para poder llegar a leer los libros objetivo,
;; donde para todo libro que pertenece al plan, todos sus libros paralelos pertenecen al 
;; plan y están en el mismo mes o en meses anteriores.
;;
(define (domain ext2_planner)
    (:requirements :strips :typing :adl :fluents)
    (:types libro - object
            mes - object
    )
    (:functions
        (numero_mes ?m - mes)     ;; numero del mes
        (ultimo_mes ?x - libro)   ;; ultimo mes asignado a un predecesor o paralelo de "x"
    )
    (:predicates
        (paralelo ?x - libro ?y - libro)     ;; "x" es paralelo de "y"
        (predecesor ?x - libro ?y - libro)   ;; "x" es predecesor de "y"
        (leer ?x - libro)                    ;; "x" es un libro que quiere leer
        (leido ?x - libro)                   ;; "x" es un libro ya leido
        (asignado ?x - libro)
    )

    (:action anyadir_libro_predecesor_a_leer
        :parameters (?x - libro ?y - libro)
        :precondition (and
                           (predecesor ?x ?y)
                           (not (leer ?x))
                           (not (leido ?x))
                       )
        :effect (leer ?x)
    )

    (:action anyadir_libro_paralelo_a_leer
        :parameters (?x - libro ?y - libro)
        :precondition (and
                           (paralelo ?x ?y)
                           (not (asignado ?x))
                       )
        :effect (leer ?x)
    )

    (:action asignar_libro_predecesor_sin_paralelos
        :parameters (?x - libro ?m - mes)
        :precondition (and
                          (leer ?x)
                          (not(asignado ?x))
                          (> (numero_mes ?m) (ultimo_mes ?x))
                          (forall (?y - libro)
                              (and
                                  (not (paralelo ?y ?x))
                                  (or
                                      (not (predecesor ?y ?x))
                                      (leido ?y)
                                  )
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

    (:action asignar_libro_paralelo
        :parameters (?x - libro ?m - mes)
        :precondition (and
                          (leer ?x)
                          (not(asignado ?x))
                          (or
                              (= (numero_mes ?m) (ultimo_mes ?x))
                              (= (numero_mes ?m) (+ (ultimo_mes ?x) 1))
                              (= (+ (numero_mes ?m) 1) (ultimo_mes ?x))
                          )
                          (forall (?y - libro)
                              (or
                                  (not (predecesor ?y ?x))
                                  (and
                                      (leido ?y)
                                      (> (numero_mes ?m) (ultimo_mes ?x))
                                  )
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
                    (forall (?y - libro)
                        (when (paralelo ?x ?y)
                            (and
                                (assign (ultimo_mes ?y) (numero_mes ?m))
                                (leer ?y)
                            )
                        )
                    )
                )
    )
)