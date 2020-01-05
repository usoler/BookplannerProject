;; Extensión 3:
;;
;; Los libros tienen además un número de páginas. 
;; 
;; El planificador controla que en el plan generado no se superen las 800 páginas al mes.
;;
(define (problem ext3_test) (:domain ext3_planner)
    (:objects L1 L2 L3 L4 L5 L6 L7 - libro
              M1 M2 M3 M4 M5 M6 M7 M8 M9 M10 M11 M12 - mes
    )
    (:init
        (predecesor L7 L1)
        (predecesor L7 L2)
        (predecesor L1 L2)
        (predecesor L5 L6)

        (leido L4)
        (leido L5)

        (leer L2)
        (leer L3)
        (leer L6)

        (= (paginas_libro L1) 500)
        (= (paginas_libro L2) 500)
        (= (paginas_libro L3) 500)
        (= (paginas_libro L4) 500)
        (= (paginas_libro L5) 500)
        (= (paginas_libro L6) 500)
        (= (paginas_libro L7) 500)

        (= (paginas_mes M1) 0)
        (= (paginas_mes M2) 0)
        (= (paginas_mes M3) 0)
        (= (paginas_mes M4) 0)
        (= (paginas_mes M5) 0)
        (= (paginas_mes M6) 0)
        (= (paginas_mes M7) 0)
        (= (paginas_mes M8) 0)
        (= (paginas_mes M9) 0)
        (= (paginas_mes M10) 0)
        (= (paginas_mes M11) 0)
        (= (paginas_mes M12) 0)

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
                   (or
                       (not (leer ?x))
                       (asignado ?x)
                    )
               )
           )
    )
)