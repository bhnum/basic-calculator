#include "mathfunction.h"

#include <string.h>

// additional functions
double cot(double a)
{
    return 1 / tan(a);
}

double acot(double a)
{
    return M_PI / 2 - atan(a);
}

double coth(double a)
{
    return 1 / tanh(a);
}

// provided functions
const char* function_names[] = {
    "cos", "sin", "tan", "cot", "cosh", "sinh", "tanh", "coth",
    "acos", "asin", "atan", "acot", "arccos", "arcsin", "arctan", "arccot",
    "exp", "ln", "log", "log10", "sqrt", "abs", "ceil", "floor",
};

double (*function_ptrs[])(double) = {
    &cos, &sin, &tan, &cot, &cosh, &sinh, &tanh, &coth,
    &acos, &asin, &atan, &acot, &acos, &asin, &atan, &acot,
    &exp, &log, &log, &log10, &sqrt, &fabs, &ceil, &floor
};

bool evaluate_function(const char* name, double value, double* result_ptr)
{
    // search for function index accroding to the name 
    int index = -1;
    for (int i = 0; i < sizeof(function_names) / sizeof(function_names[0]); i++)
        if (strcmp(name, function_names[i]) == 0)
        {
            index = i;
            break;
        }

    // function was not found
    if (index == -1)
        return false;

    // functions cos, sin, tan, cosh, sinh, tanh expect the input in radians
    // convert from degrees to radians
    if (index < 8)
        value = value * M_PI / 180;

    // calculate the result
    double result = function_ptrs[index](value);

    // functions acos, asin, atan return the result in radians
    // convert from radians to degrees
    if (index >= 8 && index < 16)
        result = result / M_PI * 180;

    // return success and assign value
    *result_ptr = result;
    return true;
}

