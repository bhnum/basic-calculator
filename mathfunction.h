#pragma once

#include <stdbool.h>
#include <math.h>

// define mathematical constants if not defined
#ifndef M_E
#define M_E 2.7182818284590452354
#endif
#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

// returns true and stores the result in result_ptr
// if the function exists, otherwise false
bool evaluate_function(const char* name, double value, double* result_ptr);
