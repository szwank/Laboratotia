#ifndef MATRIXX_H
#define MATRIXX_H
        


struct Matrix{

    int width;
    int height;
    double **data;
};

struct Matrix createEmptyMatrix(int width, int height);

double** createEmptyTable(int, int);
double* createEmptyTable2(int);

void freeMatrix(struct Matrix matrix);

void freeTable(double** table, int height);

void printMatrix(struct Matrix matrix);

struct Matrix add_Matrixes(struct Matrix matrix_a, struct Matrix matrix_b );

struct Matrix substract_Matrixes(struct Matrix matrix_a, struct Matrix matrix_b );

void assertSameSize(struct Matrix matrix_a, struct Matrix matrix_b);

struct Matrix multiply_Matrixes(struct Matrix matrix_a, struct Matrix matrix_b);

void assertSquare(struct Matrix matrix);

struct Matrix get_Transposed_Matrix(struct Matrix matrix);

struct Matrix create_diag_matrix(int size);




#endif // MATRIX
