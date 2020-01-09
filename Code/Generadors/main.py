import sys

if len(sys.argv) != 2:
    print("\nEste programa tiene como parámetro un entero del 0 al 4, para ver más información utilize el comando:")
    print("\tpython main.py -h")
elif sys.argv[1] == '-h' or sys.argv[1] == '--h' or sys.argv[1] == '-help' or sys.argv[1] == '-help':
    print("\nJuegosDePruebas Help:")
    print("\tEste programa sirve para testear el caso base, las 3 extensiones y el experimento del tiempo de la extensión 2.")
    print("\tEste programa toma como parámetro un entero del 0 al 3, que representan las siguientes funciones:")
    print("\t\t0: Genera un juego de prueba aleatorio para el nivel básico y lo ejecuta.")
    print("\t\t1: Genera un juego de prueba aleatorio para el la extensión 1 y lo ejecuta.")
    print("\t\t2: Genera un juego de prueba aleatorio para el la extensión 2 y lo ejecuta.")
    print("\t\t3: Genera un juego de prueba aleatorio para el la extensión 3 y lo ejecuta.")
    print("\t\t4: Experimenta con el tamaño de los libros de la extensión 2 y genera una gráfica del tiempo")
elif sys.argv[1] == '0':
    import jp_Generator_Basico
elif sys.argv[1] == '1':
    import jp_Generator_Ext1
elif sys.argv[1] == '2':
    import jp_Generator_Ext2
elif sys.argv[1] == '3':
    import jp_Generator_Ext3
elif sys.argv[1] == '4':
    import jp_Ext2_Creciente
else:
    print("\nError al introducir el parámetro.")
    print("Este programa tiene como parámetro un entero del 0 al 4, para ver más información utilize el comando:")
    print("\tpython main.py -h")
