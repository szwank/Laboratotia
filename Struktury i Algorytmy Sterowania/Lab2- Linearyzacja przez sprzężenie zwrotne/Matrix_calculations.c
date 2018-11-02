#include "Matrix_calculations.h"
#include "stdio.h"
#include "stdlib.h"

struct Matrix createEmptyMatrix(int height, int width)
{
    struct Matrix matrix;
    matrix.width = width;
    matrix.height = height;
    matrix.data = createEmptyTable(height, width);
    return matrix;
}

double** createEmptyTable(int height, int width)
{
    double** table = (double**)malloc(height*sizeof(double*));
    int i;
    for(i=0; i<height; i++)
        table[i] = createEmptyTable2(width);
    return table;
}

double* createEmptyTable2(int size)
{
    double* table = (double*)malloc(size*sizeof(double));
    int i;
    for(i=0; i<size; i++)
        table[i] = 0;
    return table;
}

void printMatrix(struct Matrix matrix)
{
    int i, j;
    for(i=0; i<matrix.height; i++)
    {
        for(j=0; j<matrix.width; j++)
            printf("%f ", matrix.data[i][j]);
        printf("\n");
    }
    printf("\n");
}

void freeMatrix(struct Matrix matrix)
{
    freeTable(matrix.data, matrix.height);
}

void freeTable(double** data, int height)
{
    int i;
    for(i=0; i<height; i++)
        free(data[i]);
    free(data);
}

struct Matrix add_Matrixes(struct Matrix matrix_a, struct Matrix matrix_b )
{
    assertSameSize(matrix_a, matrix_b);

    struct Matrix result = createEmptyMatrix(matrix_a.height, matrix_a.width);
    int i, j;
    for (i = 0; i < matrix_a.width; i++)
        for (j = 0; j < matrix_b.height; j++)
            result.data[j][i] = matrix_a.data[j][i] + matrix_b.data[j][i];

    return result;
}

struct Matrix substract_Matrixes(struct Matrix matrix_a, struct Matrix matrix_b )
{
    assertSameSize(matrix_a, matrix_b);

    struct Matrix result = createEmptyMatrix(matrix_a.height, matrix_a.width);


    int i, j;
    for (i = 0; i < matrix_a.width; i++)
        for (j = 0; j < matrix_b.height; j++)
            result.data[j][i] = matrix_a.data[j][i] - matrix_b.data[j][i];

    return result;
}

void assertSameSize(struct Matrix matrix_a, struct Matrix matrix_b)
{
    if (matrix_a.width != matrix_b.width ||
            matrix_a.height != matrix_b.height)
    {
        printf("wymiary macieerzy się nie zgadzaja");
        //ssSetErrorStatus(S,"The dimensions of the matrixes do not match");
        //return;
    }

}

struct Matrix multiply_Matrixes(struct Matrix matrix_a, struct Matrix matrix_b)
{
    if (matrix_a.width != matrix_b.height)
    {
        printf("wymiary macierzy się nie zgają- mnożenie");
        exit(0);
    }

    struct Matrix result = createEmptyMatrix(matrix_b.height, matrix_a.width);

    int i, j;
    for (i = 0; i < matrix_a.width; i++)
    {
        for (j = 0; j < matrix_b.height; j++)
        {
            double value = 0;
            int k;
            for (k = 0; k < matrix_b.height; k++)
                value += matrix_a.data[j][k] * matrix_b.data[k][i];

            result.data[j][i] = value;
        }
    }
    return result;
}




void assertSquare(struct Matrix matrix)
{
    if (matrix.height != matrix.width )
    {
        printf("macierz nie jest kwadratowa");
        exit(0);
    }
}



struct Matrix get_Transposed_Matrix(struct Matrix matrix)
{
    struct Matrix result = createEmptyMatrix(matrix.width, matrix.height);

    int i, j;
    for (i = 0; i < matrix.height; i++)
        for (j = 0; j < matrix.width; j++)
            result.data[j][i] = matrix.data[i][j];
    return result;
}




struct Matrix create_diag_matrix(int size)
{
    struct Matrix result  = createEmptyMatrix(size, size);

    int i, j;
    for (i = 0; i < size; i++)
        for (j = 0; j < size; j++)
            if(i == j)
                result.data[i][j] = 1;
            else
                result.data[i][j] = 0;

    return result;
}

struct Matrix createMatrix(real_T *array, int height, int width)
{
    struct Matrix matrix = createEmptyMatrix(height, width);
    matrix.height = height;
    matrix.width = width;
    
    double** table = (double**)malloc(height*sizeof(double*));
    
    for(int i = 0; i < height; i ++)
    {
        double *line = (double*)malloc(width*sizeof(double));
        
        for (int j = 0; j < width; j++)
            line[j] = array[j + height*(i-1)];

        table[i] = line;
    }
    matrix.data = table;
    return matrix;
}
