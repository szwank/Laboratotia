

/*
 * Include Files
 *
 */
#if defined(MATLAB_MEX_FILE)
#include "tmwtypes.h"
#include "simstruc_types.h"
#else
#include "rtwtypes.h"
#endif



/* %%%-SFUNWIZ_wrapper_includes_Changes_BEGIN --- EDIT HERE TO _END */

#include "Matrix_calculations.h"
/* %%%-SFUNWIZ_wrapper_includes_Changes_END --- EDIT HERE TO _BEGIN */
#define u_width 1
#define y_width 1
/*
 * Create external references here.  
 *
 */
/* %%%-SFUNWIZ_wrapper_externs_Changes_BEGIN --- EDIT HERE TO _END */
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

/* %%%-SFUNWIZ_wrapper_externs_Changes_END --- EDIT HERE TO _BEGIN */

/*
 * Output functions
 *
 */
void pruba_Outputs_wrapper(const real_T *u0,
			real_T *y0)
{
/* %%%-SFUNWIZ_wrapper_Outputs_Changes_BEGIN --- EDIT HERE TO _END */
/* This sample sets the output equal to the input
      y0[0] = u0[0]; 
 For complex signals use: y0[0].re = u0[0].re; 
      y0[0].im = u0[0].im;
      y1[0].re = u1[0].re;
      y1[0].im = u1[0].im;
*/
/* %%%-SFUNWIZ_wrapper_Outputs_Changes_END --- EDIT HERE TO _BEGIN */
}
