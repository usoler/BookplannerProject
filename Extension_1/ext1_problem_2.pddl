;; Extensión 1:
;; 
;; Los libros pueden tener de 0 a N predecesores pero ningún paralelo.
;;
;; El planner es capaz de construir un plan para poder llegar a leer los libros 
;; objetivo, donde para todo libro que pertenece al plan, todos sus libros predecesores
;; pertenecen al plan y están en meses anteriores.
;;
(define (problem ext1_test_2) (:domain ext1_planner)
    (:objects L1 L2 L3 L4 L5 L6 L7 L8 - libro
              M1 M2 M3 M4 M5 M6 M7 M8 M9 M10 M11 M12 - mes
    )
    (:init
        (predecesor L7 L1)
        (predecesor L7 L2)
        (predecesor L1 L2)
        (predecesor L5 L6)
        (leido L4)
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
    )

    (:goal (and 
               (forall (?x - libro) 
                   (not (leer ?x))
               )
           )
    )
)