import sys

if len(sys.argv) != 2:
    print("\nEste programa tiene como parámetro un entero del 0 al 3, para ver más información utilize el comando:")
    print("\tpython main.py -h")
elif sys.argv[1] == '-h' or sys.argv[1] == '--h' or sys.argv[1] == '-help' or sys.argv[1] == '-help':
    print("\nJuegosDePruebas Help:")
    print("\tEste programa sirve para testear el caso base y las 3 extensiones.")
    print("\tEste programa toma como parámetro un entero del 0 al 3, que representan las siguientes funciones:")
    print("\t\t0: Genera un juego de prueba aleatorio para el nivel básico y lo ejecuta.")
    print("\t\t1: Genera un juego de prueba aleatorio para el la extensión 1 y lo ejecuta.")
    print("\t\t2: Genera un juego de prueba aleatorio para el la extensión 2 y lo ejecuta.")
    print("\t\t3: Genera un juego de prueba aleatorio para el la extensión 3 y lo ejecuta.")
elif sys.argv[1] == '0':
    import jp_Generator_Basico
elif sys.argv[1] == '1':
    import jp_Generator_Ext1
elif sys.argv[1] == '2':
    import jp_Generator_Ext2
else:
    print("\nError al introducir el parámetro.")
    print("Este programa tiene como parámetro un entero del 0 al 3, para ver más información utilize el comando:")
    print("\tpython main.py -h")
