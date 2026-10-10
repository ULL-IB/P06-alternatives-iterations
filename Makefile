# Universidad de La Laguna
# Escuela Superior de Ingeniería y Tecnología
# Grado en Ingeniería Informática
# Informática Básica
#
# @author Javier Hdez. Aceituno
# @date Oct 09, 2026
# @brief Ejemplo de Makefile para programas simples en C++

# Variables de configuración:
# CXX:      Compilador a usar
# CSSFLAGS: Opciones de compilación (en este caso
#           usaremos C++17 y activaremos todos los avisos)
# LDFLAGS:  Opciones de enlazado, si las hubiera
#           (en este caso, no necesitamos ninguna)

CXX = g++
CXXFLAGS = -std=c++17 -Wall
LDFLAGS =

# El objetivo 'all' construye todos los programas incluidos
# en el Makefile; en este caso sólo está 'digits', si hubiera
# más se añadirían a continuación, separados por espacios:

all: digits

# Para construir el programa 'digits', necesitaremos el código
# objeto 'digits.o' (definido en otra regla más abajo) y el
# comando '$(CXX) $(CXXFLAGS) -o $@ $^ $(LDFLAGS)', que en este
# caso equivale a 'g++ -std=c++17 -Wall -o digits digits.o':

digits: digits.o 
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LDFLAGS)

# La regla '.PHONY' sólo indica que 'all' y 'clean' no son
# ficheros a generar, sino etiquetas para comandos concretos.

.PHONY: all clean

# La regla siguiente indica que, para construir el código objeto
# 'digits.o', necesitaremos el código fuente 'digits.cc' y ejecutar
# '$(CXX) $(CXXFLAGS) -c $<' ('g++ -std=c++17 -Wall -c digits.cc').
# Esta regla se aplica por defecto siempre que falte un código objeto
# y no es necesario incluirla manualmente en el fichero Makefile.

digits.o: digits.cc
	$(CXX) $(CXXFLAGS) -c $<

# La regla 'clean' elimina todos los ficheros ejecutables y códigos
# objeto que se haya generado el proceso de compilación. Se puede
# utilizar para cualquier otra tarea de limpieza adicional. Utilice
# siempre esta regla antes de comprimir los ficheros de su entrega.

clean :
	rm -f *.o digits *~ a.out

# Eliminando todos los comentarios y modificando el resto para cada
# programa individual, puede utilizar este fichero como base para
# sus prácticas de programación de la asignatura.
