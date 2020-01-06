;; Extensión 2: 
;;
;; Extensión 1 + los libros pueden tener de 0 a M libros paralelos. 
;;
;; El planner es capaz de construir un plan para poder llegar a leer los libros objetivo,
;; donde para todo libro que pertenece al plan, todos sus libros paralelos pertenecen al 
;; plan y están en el mismo mes o en meses anteriores.
;;
(define (problem ext2_test_4) (:domain ext2_planner)
    (:objects L1 L2 L3 L4 L5 L6 L7 L8 - libro
              M1 M2 M3 M4 M5 M6 M7 M8 M9 M10 M11 M12 - mes
    )
    (:init
        (predecesor L7 L1)
        (predecesor L7 L2)
        (predecesor L1 L2)
        (predecesor L8 L5)
        (predecesor L8 L6)
        (predecesor L5 L6)

        (leido L4)
        (leido L8)
        (leido L5)

        (leer L2)
        (leer L3)
        (leer L6)

        (= (numero_mes M1) 1)
        (= (numero_mes M2) 2)
        (= (numero_mes M3) 3)
        (= (numero_mes M4) 4)
        (= (numero_mes M5) 5)
        (= (numero_mes M6) 6)
        (= (numero_mes M7) 7)
        (= (numero_mes M8) 8)
        (= (numero_mes M9) 9)
        (= (numero_mes M10) 10)
        (= (numero_mes M11) 11)
        (= (numero_mes M12) 12)

        (= (ultimo_mes L1) 0)
        (= (ultimo_mes L2) 0)
        (= (ultimo_mes L3) 0)
        (= (ultimo_mes L4) 0)
        (= (ultimo_mes L5) 0)
        (= (ultimo_mes L6) 0)
        (= (ultimo_mes L7) 0)
        (= (ultimo_mes L8) 0)
    )

    (:goal (and 
               (forall (?x - libro)
                   (or
                       (not (leer ?x))
                       (asignado ?x)
                       (leido ?x)
                    )
               )
           )
    )
)