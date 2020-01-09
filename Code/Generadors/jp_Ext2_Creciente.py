import sys
import os
import random
import time

#Devuelve True si predecesor tiene algun descendiente en dag:
def tienePredecesor(dag, descendiente):
    for lista in dag:
        if descendiente in lista:
            return True
    return False

def connect(dag):
    for i in range(len(dag)):#para cada libro
        l = dag[i]
        if len(l) > 0:#si tiene descendientes
            last = l[-1]
            while len(dag[last]) > 0:#si su último descendiente tiene más descendientes
                l.extend(dag[last])
                last = l[-1]
                        

vTime = [0 for x in range(11)]
#Generamos un numero aleatorio de libros:
for nLibros in range(1, 12):
    for k in range(5):
        #Creamos un string con los nombres de cada libro, en formatio Li:
        strNombres = ""
        for i in range(nLibros):
            strNombres += "L"+str(i)+" "

        dag = [[]for x in range(nLibros)]#Este dag representa por cada libro, sus descendientes

        #Con una probabilidad del 50% le asignamos un predecesor aleatirio a cada libro.
        for i in range(nLibros):
            p = random.randint(0, 100)
            if p <= 25: #le intentamos dar un predecesor
                predecesor = random.randint(0, nLibros-1)
                countTimes = 0 #un contador para no quedarnos en un bucle infinto. Si intentamos asignarle 25 predecesores sin exito, no le asignamos un predecesor

                while (predecesor == i or predecesor in dag[i]) and countTimes < 25:
                    predecesor = random.randint(0, nLibros-1)
                    countTimes += 1

                if countTimes < 25:#le asignamos el predecesor
                    dag[predecesor].append(i)
                    dag[predecesor].extend(dag[i].copy())
                    connect(dag)

        #Escribimos en el fichero:
        #primero generamos el texto:
        pddlText =  "(define (problem test) (:domain ext2_planner)\n" 
        pddlText += "   (:objects "+ strNombres +"- libro\n"
        pddlText += "             M1 M2 M3 M4 M5 M6 M7 M8 M9 M10 M11 M12 - mes)\n" 
        pddlText += "	(:init\n"

        for lib in range(nLibros):
            for descendiente in dag[lib]:
                pddlText += "\t\t(predecesor L"+str(lib)+" L"+str(descendiente)+")\n"

        pddlText += "\n"

        vLeer = []
        for i in range(nLibros):
            p = random.randint(0, 100)
            if p <= 25:
                pddlText += "\t\t(leer L"+str(i)+")\n"
                vLeer.append(i)

        pddlText +="\n"

        vLeidos = []
        for i in range(nLibros):
            p = random.randint(0, 100)
            if p <= 25 and i not in vLeer:
                pddlText += "\t\t(leido L"+str(i)+")\n"
                vLeidos.append(i)


        pddlText +="\n"

        for i in range(nLibros):
            pddlText += "\t\t(= (ultimo_mes L"+str(i)+") 0)\n"

        pddlText +="\n"

        pddlText +="\t\t(= (numero_mes M1) 1)\n"
        pddlText +="\t\t(= (numero_mes M2) 2)\n"
        pddlText +="\t\t(= (numero_mes M3) 3)\n"
        pddlText +="\t\t(= (numero_mes M4) 4)\n"
        pddlText +="\t\t(= (numero_mes M5) 5)\n"
        pddlText +="\t\t(= (numero_mes M6) 6)\n"
        pddlText +="\t\t(= (numero_mes M7) 7)\n"
        pddlText +="\t\t(= (numero_mes M8) 8)\n"
        pddlText +="\t\t(= (numero_mes M9) 9)\n"
        pddlText +="\t\t(= (numero_mes M10) 10)\n"
        pddlText +="\t\t(= (numero_mes M11) 11)\n"
        pddlText +="\t\t(= (numero_mes M12) 12)\n"

        pddlText +="\n"

        pddlText +=    "\t)\n"
        pddlText +=    "\t\t(:goal (and\n"
        pddlText +=    "\t\t\t(forall (?x - libro)\n"
        pddlText +=    "\t\t\t\t(or\n"
        pddlText +=    "\t\t\t\t\t(not (leer ?x))\n"
        pddlText +=    "\t\t\t\t\t(asignado ?x)\n"
        pddlText +=    "\t\t\t\t\t(leido ?x)\n"
        pddlText +=    "\t\t\t\t)\n"
        pddlText +=    "\t\t\t)\n"
        pddlText +=    "\t\t)\n"
        pddlText +=    "\t)\n"
        pddlText +=    ")"

        #después escribimos el texto generado en un fichero pddl
        os.makedirs(os.path.dirname("./JuegosDePruebaGenerados/ext2_problem_generated.pddl"), exist_ok=True)
        with open("./JuegosDePruebaGenerados/ext2_problem_generated.pddl", "w") as juegoDePrueba:
            juegoDePrueba.write(pddlText)

        #Describimos el problema:
        print("\nProblema número "+str(nLibros)+":")
        print("\tLibros: \t"+strNombres)
        print("\tPredecesores:")
        for i in range(nLibros):
            for descendiente in dag[i]:
                print("\t\tL"+str(i)+" -> L"+str(descendiente))
        print("\tPara leer:")
        for l in vLeer:
            print("\t\tL"+str(l))
        print("\tLeidos:")
        for l in vLeidos:
            print("\t\tL"+str(l))
        print("\nOutput:")

        #Ejecutamos y guardamos el output para leerlo mas tarde:
        start_time = time.time()
        try:
            os.system("../../Metric-FF/ff -o ../Extension_2/ext2_domain.pddl -f ./JuegosDePruebaGenerados/ext2_problem_generated.pddl")
        except:
            print("Error al ejecutar el programa")
        temps = time.time()-start_time
        vTime[nLibros-1] += temps
        print("Tiempo de resolución: "+str(temps))
        
    vTime[nLibros-1] /= 5
    
print("\n\nResultados de todas las generaciones:")
print("tiempo:")
print(vTime)
import matplotlib.pyplot as plt
plt.plot([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], vTime)
plt.ylabel('Tiempo de ejecución')
plt.xlabel('Núm de libros')
plt.show()

