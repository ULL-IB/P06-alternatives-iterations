/**
 * Universidad de La Laguna
 * Escuela Superior de Ingeniería y Tecnología
 * Grado en Ingeniería Informática
 * Informática Básica
 *
 * @author Javier Hdez. Aceituno
 * @date Oct 12 2025
 * @brief Count the number of decimal digits of an integer power
 * @bug The number of digits might be inaccurate in case of long int overflow
 */

#include <iostream>

int main() {
  int base{0}, exponent{0};
  std::cout << "Base: ";
  std::cin >> base;
  std::cout << "Exponent: ";
  std::cin >> exponent;
  
  // Special cases
  if (exponent < 0) {  // If negative, the result could be non-integer
    std::cerr << "Only positive exponents, please" << std::endl;
    return 1;
  } else if (base == 0) {
    if (exponent == 0) {  // 0^0 cannot be computed mathematically
      std::cerr << "0^0 is undefined" << std::endl;
      return 1;
    } else {  // 0^N (N > 0) is always 0, no need to compute
      std::cout << "0^" << exponent << " = 0 (1 digit)" << std::endl;
      return 0;
    }
  }
  
  // Compute power by repeatedly multiplying by 'base'
  long power{1};
  for (int i{0}; i < exponent; ++i) {  // Repeat 'exponent' times
    power *= base;
  }
  std::cout << base << '^' << exponent << " = " << power;
  
  // Compute number of digits of power by repeatedly dividing by 10
  short digits{0};
  while (power > 0) {  // Repeat until 'power' is zero
    power /= 10;
    ++digits;
  }
  std::cout << " (" << digits << " digits)" << std::endl;
  return 0;
}

