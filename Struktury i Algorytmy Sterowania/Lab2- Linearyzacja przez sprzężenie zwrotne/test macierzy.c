#include "Matrix_calculations.h"
#include "stdio.h"

int main()
{
    struct Matrix matrix;
    createEmptyMatrix(2, 2);
    matrix.width = 2;
    printf("%d\n", matrix.width);
    return 0;
}
