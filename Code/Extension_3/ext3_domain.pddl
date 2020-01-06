;; Extensión 3:
;;
;; Los libros tienen además un número de páginas. 
;; 
;; El planificador controla que en el plan generado no se superen las 800 páginas al mes.
;;an y están en el mismo mes o en meses anteriores.
;;
(define (domain ext3_planner)
    (:requirements :strips :typing :adl :fluents)
    (:types libro - object
            mes - object
    )
    (:functions
        (numero_mes ?m - mes)      ;; numero del mes
        (ultimo_mes ?x - libro)    ;; ultimo mes asignado a un predecesor o paralelo de "x"
        (paginas_libro ?x - libro) ;; numero de paginas del libro
        (paginas_mes ?m - mes)     ;; numero de paginas asignadas al mes
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
                          (<= (+ (paginas_mes ?m) (paginas_libro ?x)) 800)
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
                    (increase (paginas_mes ?m) (paginas_libro ?x))
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
                          (<= (+ (paginas_mes ?m) (paginas_libro ?x)) 800)
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
                    (increase (paginas_mes ?m) (paginas_libro ?x))
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