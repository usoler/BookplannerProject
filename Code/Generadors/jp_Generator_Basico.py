import sys
import os
import random

#Generamos un numero aleatorio de libros:
nLibros = random.randint(1, 25)#minimo un libro

#Creamos un string con los nombres de cada libro, en formatio Li:
strNombres = ""
vPredecesores = []
for i in range(nLibros):
    strNombres += "L"+str(i)+" "
    vPredecesores.append(-1)

#Con una probabilidad del 50% le asignamos un predecesor aleatirio a cada libro.
vPredecesoresAsignados = [] #vector donde guardamos los predecesores ya asignados, para evitar paralelismos
for i in range(nLibros):
    p = random.randint(0, 100)
    if p >= 50 and i not in vPredecesoresAsignados: #le intentamos dar un predecesor
        predecesor = random.randint(0, nLibros-1)
        countTimes = 0 #un contador para no quedarnos en un bucle infinto. Si intentamos asignarle 50 predecesores sin exito, no le asignamos un predecesor
        while (predecesor == i or vPredecesores[predecesor] == i or predecesor in vPredecesoresAsignados) and countTimes < 50:
            predecesor = random.randint(0, nLibros-1)
            countTimes += 1

        if countTimes < 50:#le asignamos el predecesor
            vPredecesores[i] = predecesor
            vPredecesoresAsignados.append(predecesor)
            vPredecesoresAsignados.append(i)

#Escribimos en el fichero:
#primero generamos el texto:
pddlText =  "(define (problem test) (:domain basic_planner)\n" 
pddlText += "   (:objects "+ strNombres +"- libro)\n" 
pddlText += "	(:init\n"

for i in range(len(vPredecesores)):
        lib = vPredecesores[i]
        if lib != -1:
            pddlText += "\t\t(predecesor L"+str(lib)+" L"+str(i)+")\n"

pddlText += "\n"

vLeer = []
for i in range(nLibros):
    p = random.randint(0, 100)
    if p >= 50:
        pddlText += "\t\t(leer L"+str(i)+")\n"
        vLeer.append(i)

pddlText +="\n"

vLeidos = []
for i in range(nLibros):
    p = random.randint(0, 100)
    if p >= 50 and i not in vLeer:
        pddlText += "\t\t(leido L"+str(i)+")\n"
        vLeidos.append(i)

pddlText +="\n"

pddlText +=    "\t)\n"
pddlText +=    "\t\t(:goal (and\n"
pddlText +=    "\t\t\t(forall (?x - libro)\n"
pddlText +=    "\t\t\t\t(not (leer ?x))\n"
pddlText +=    "\t\t\t)\n"
pddlText +=    "\t\t)\n"
pddlText +=    "\t)\n"
pddlText +=    ")"

#después escribimos el texto generado en un fichero pddl
os.makedirs(os.path.dirname("./JuegosDePruebaGenerados/basic_problem_generated.pddl"), exist_ok=True)
with open("./JuegosDePruebaGenerados/basic_problem_generated.pddl", "w") as juegoDePrueba:
    juegoDePrueba.write(pddlText)

#Describimos el problema:
print("\nProblema:")
print("\tLibros: \t"+strNombres)
print("\tPredecesores:")
for i in range(len(vPredecesores)):
    if vPredecesores[i] != -1:
        print("\t\tL"+str(vPredecesores[i])+" -> L"+str(i))
print("\tPara leer:")
for l in vLeer:
    print("\t\tL"+str(l))
print("\tLeidos:")
for l in vLeidos:
    print("\t\tL"+str(l))
print("\nOutput:")


#Ejecutamos y guardamos el output para leerlo mas tarde:
try:
    os.system("../../FF-v2.3/ff -o ../Nivel_basico/basic_domain.pddl -f ./JuegosDePruebaGenerados/basic_problem_generated.pddl")
except:
    print("Error al ejecutar el programa")


