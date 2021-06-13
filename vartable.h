#pragma once

#include <stdbool.h>

void setvar(const char* name, double value);

// returns true is variable exists, otherwise false
bool getvar(const char* name, double* value);
