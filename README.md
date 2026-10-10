# Práctica 06. Alternativas e Iteraciones. Make.

# Factor de ponderación: 6

### Objetivos
Los objetivos de esta práctica son que el alumnado:
- Sea capaz de resolver problemas sencillos en C++ usando todos los conocimientos adquiridos hasta ahora, y en particular haciendo uso de sentencias alternativas y de iteración.
- Conozca la herramienta `make` y que sea capaz de configurar ficheros `Makefile` sencillos para la automatización de la compilación de sus programas.

### Rúbrica de evaluacion de esta práctica
Se señalan a continuación los aspectos más relevantes (la lista no es exhaustiva) que se tendrán en cuenta a la hora de evaluar esta práctica. Se comprobará que el alumnado:
- Es capaz de escribir programas simples en C++ que resuelvan problemas de complejidad similar a los que se han propuesto para esta práctica
- Ha automatizado la compilación de sus programas usando un fichero `Makefile` para cada uno de los programas que desarrolle 
- Acredita que es capaz de subir programas a la plataforma [Jutge](https://jutge.org/) para su evaluación
- Ha incluido un comentario prólogo en todos los ficheros (`*.cc`, `*.h`) de sus ejercicios
- Hace que todos los programas de sus prácticas se ajusten a la [Guía de estilo de Google para C++](https://google.github.io/styleguide/cppguide.html) 
- Acredita que es capaz de editar ficheros remotos en su VM usando vi
- Demuestra que es capaz de ejecutar comandos Linux en su VM

Recuerde que para cada práctica tiene que entregar un fichero `.tar.gz` conteniendo todos los programas que desarrolle tanto antes como durante la sesión de evaluación. Este fichero sólo debe entregarse **al terminar la sesión de evaluación,** antes de abandonar la sala del Centro de Cálculo.

### La utilidad `make`
Hasta ahora en la asignatura se han compilado los programas de forma manual, invocando al compilador con un comando como
```
$ g++ -std=c++17 -Wall -o hello_world hello_world.cc
```
La compilación manual de programas es por lo general bastante tediosa, especialmente cuando el programa consta de varios ficheros con código fuente y es necesario especificar opciones adicionales del compilador. En la práctica, lo más común es usar herramientas para automatizar el proceso de compilación. [`make`](https://en.wikipedia.org/wiki/Make_(software)) es una de las herramientas más usadas para tal propósito. Su función es determinar automáticamente qué ficheros de un programa necesitan ser recompilados y ejecutar los comandos necesarios para realizar esa tarea.

Comience su estudio de `make` estudiando [este tutorial](https://makefiletutorial.com/) y reproduciendo en su máquina virtual y entendiendo cada uno de los ejemplos, hasta el apartado *Static Pattern Rules.* Estudie también [este otro tutorial](https://cs.colby.edu/maxwell/courses/tutorials/maketutor/); en él se utiliza el compilador `gcc`, pero puede Ud. sustituirlo por `g++` puesto que el compilador de C++ compila igualmente el código en C (como se ha explicado, C++ es un superconjunto de C). En [este
directorio](https://github.com/ULL-IB/P06-alternatives-iterations/blob/main/make-tutorial) puede encontrar los ejercicios de ese tutorial adaptados al compilador `g++`, incluyendo:

- El programa principal `hellomake.cc`
- El fichero `hellofunc.cc` en el que figura el código de la función `myPrintHelloMake()`
- El fichero `hellomake.h` en el que figura la definición de dicha función

Ésta es la situación habitual en la que una aplicación desarrollada en C++ consta no de tres sino, en general, de decenas de ficheros que hay que compilar. Una compilación manual de ese programa se realizaría con los comandos:

``` .bash
g++ -std=c++17 -Wall -c hellomake.cc
g++ -std=c++17 -Wall -c hellofunc.cc
g++ -o hellomake hellomake.o hellofunc.o
```
Los dos primeros comandos compilan el correspondiente código fuente, generando solamente su código objeto (ficheros `*.o`); el tercero invoca al enlazador (*linker*) para construir el fichero binario ejecutable `hellomake` a partir de dichos códigos objeto.

Estudie cuidadosamente las explicaciones de ese tutorial. En el directorio puede hallar las 5 versiones del fichero `Makefile` que se estudian en ese tutorial. Para utilizar cualquiera de ellos (por ejemplo, el fichero `makefile.2`) ejecute el comando
``` .bash
make -f makefile.2
```
Recuerde que para que `make` utilice el fichero por defecto, éste ha de llamarse `Makefile`, en cuyo caso basta con ejecutar
``` .bash
make 
```

Para finalizar, en [el directorio principal del repositorio de esta práctica](https://github.com/ULL-IB/P06-alternatives-iterations) puede estudiar un fichero `Makefile` que se utiliza para compilar el programa `digits.cc`. Ese fichero contiene comentarios indicando la finalidad de cada una de las líneas que figuran en el mismo. Debería Ud. estudiar cada una de esas líneas y comprender su finalidad y formato, teniendo en cuenta lo aprendido en los tutoriales enlazados al comienzo de esta sección.

- Tenga en cuenta que el formato del fichero `Makefile` requiere que en algunos puntos del mismo haya un caracter tabulador (*tab*, `\t`) y no acepta espacios en su lugar. Tal es el caso en las líneas 33, 47 y 55.
- La línea 25 es la que especifica el nombre del fichero ejecutable que ha de construir `make`, que en este caso es `digits`.
- Se indica en la línea 32 que el fichero `digits` depende del código objeto `digits.o`. La línea 33 indica cómo *construir* el fichero `digits` a partir de `digits.o`, invocando al enlazador (*linker*) con una línea como:
    
    ``` .bash
    g++ -std=c++17 -Wall -o digits digits.o
    ```
- Las líneas 46 y 47 indican cómo construir los códigos objeto (`.o`) a partir de su correspondientes códigos fuente (`.cc`):
    
    ``` .bash
    g++ -std=c++17 -Wall -c -o digits.o digits.cc
    ```
    Esta línea invoca al compilador con la opción `-c` (solo compilar, sin enlazar) para producir el código objeto (`digits.o`) a partir del fichero fuente (`digits.cc`). Observe que ese comando es el primero que se ejecuta al invocar a `make` (`all` depende de `digits`, que depende de `digits.o`).
    
    Sin embargo, como indica el comentario, esa regla no necesita especificarse explícitamente, porque `make` ya la contempla por defecto. Pruebe a comentar ambas líneas con `#` y observará que la compilación aún se realiza correctamente.
- Por último, observe que los comandos que figuran después de la línea 54 se ejecutan al invocar:
    
    ``` .bash
    make clean
    ```
    Se puede utilizar cualquier otra etiqueta, pero la costumbre es utilizar la etiqueta `clean`. La finalidad de estos comandos (que puede Ud. configurar a su gusto) es borrar todos aquellos ficheros que, siendo producto de la compilación/edición del proyecto, no se desea retener. Así por ejemplo los ficheros `*.o` con código objeto o el fichero ejecutable (`digits` en este caso) no conviene conservarlos, puesto que ocupan espacio y, como se pueden obtener a partir del codigo fuente, no son necesarios.

Estudie detenidamente este fichero `Makefile`. Puede reutilizar éste o cualquier otro de los que haya generado para proyectos futuros, sustituyendo el nombre del programa a generar y de los códigos fuente y objeto por los que correspondan a cada ejercicio. Pruebe a crear una cuarta variable que indique el nombre del programa, de forma que sea más sencillo hacer dicha sustitución con cada reutilización del fichero. Por ejemplo:

``` .bash
CXX = g++
CXXFLAGS = -std=c++17 -Wall
LDFLAGS =
PROG = digits

all: $(PROG)

$(PROG): $(PROG).o 
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LDFLAGS)
 
.PHONY: all clean

clean :
	rm -f *.o $(PROG) *~ a.out
```
Tenga en cuenta que el fichero `Makefile` será más complejo una vez comencemos a generar programas con más de un fichero de código fuente (`.cc`), en prácticas futuras.

### Alternativas e iteraciones
Para el desarrollo de esta práctica será necesario saber programar sentencias condicionales e iterativas en C++. Recuerde que, a grandes rasgos, su funcionamiento es el siguiente:

``` c++
if (condición) {
  sentencias_1;
} else {
  sentencias_2;
}

for (inicio; condición; incremento) {
  sentencias;
}

while (condición) {
  sentencias;
}
```

En el bloque `if-else` anterior, si la `condición` booleana se cumple, se ejecutará `sentencias_1`; si no se cumple, se ejecutará `sentencias_2`. Si `sentencias_2` estuviera vacío, no sería necesario escribir el bloque `else`. 

En un bucle `for` se puede especificar una sentencia de `inicio` que puede incluir declaraciones de variables, una `condición` booleana que deberá cumplirse para que el bucle continúe en ejecución, y una sentencia de `incremento` que se ejecutará después de cada iteración del bloque de `sentencias`. En resumen, en un bucle `for` se ejecutará primero la sentencia de `inicio` y luego, mientras que la `condición` sea *verdadera*, se ejecutará repetidamente (iterativamente) el bloque de `sentencias` y el `incremento`.

Los bucles `for` deben usarse cuando se conoce de antemano el número de iteraciones a ejecutar; en caso contrario, es mejor utilizar bucles `while`, que carecen de sentencias de `inicio` e `incremento`. En un bucle `while`, mientras que la `condición` sea *verdadera*, se ejecutará iterativamente el bloque de `sentencias`.

Estudie el código [`digits.cc`](https://github.com/ULL-IB/P06-alternatives-iterations/blob/main/digits.cc) incluido en el repositorio de esta práctica para ver un ejemplo de las tres estructuras.

### Material de estudio complementario
Estudie del [tutorial de referencia](https://www.learncpp.com/) en la asignatura los siguientes apartados:
- 2.1 [Introduction to functions](https://www.learncpp.com/cpp-tutorial/introduction-to-functions/)
- Del capítulo 7 los apartados 7.1 al 7.11

### Ejercicios
- Escriba programas que solucionen los siguientes problemas y evalúe su solución utilizando Jutge
- Al realizar los ejercicios, cree dentro del directorio de la práctica un subdirectorio diferente para cada uno de los ejercicios. Asigne a cada uno de esos directorios nombres significativos (por ejemplo, `P34279_add-one-second`)
- Automatice la compilación de cada programa con un fichero `Makefile` independiente, que deberá incluir en el correspondiente subdirectorio

1. [P98960](https://jutge.org/problems/P98960_en) Uppercase and lowercase letters
2. [P90615](https://jutge.org/problems/P90615_en) Maximum of three integer numbers
3. [P34279](https://jutge.org/problems/P34279_en) Add one second
4. [P97156](https://jutge.org/problems/P97156_en) Numbers in an interval
5. [P59539](https://jutge.org/problems/P59539_en) Harmonic numbers (1)

Tenga en cuenta que en la evaluación de las prácticas de *Informática Básica* puede incluir ejercicios de Jutge, así que es buena idea intentar resolver tantos ejercicios de dicha plataforma como se pueda. No se preocupe si no consigue solucionar alguno de los problemas concretos, es preferible que centre sus esfuerzos en realizar muchos programas que en solucionar alguno concreto.

Recuerde siempre que, aunque Jutge solo evalúa la corrección de su programa desde el punto de vista de su funcionamiento, su código debe cumplir además con los requisitos de modularidad, formato y estilo.
