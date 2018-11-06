/*
 * sfuntmpl_basic.c: Basic 'C' template for a level 2 S-function.
 *
 * Copyright 1990-2013 The MathWorks, Inc.
 */


/*
 * You must specify the S_FUNCTION_NAME as the name of your S-function
 * (i.e. replace sfuntmpl_basic with the name of your S-function).
 */

#define S_FUNCTION_NAME  filtr_kalmana
#define S_FUNCTION_LEVEL 2
#define DEBUG

/*
 * Need to include simstruc.h for the definition of the SimStruct and
 * its associated macro definitions.
 */
#include "simstruc.h"
#include "matrix.h"
//#include "stdio.h"
/******************************************************************************************************************************
                                                    Funkcje
 *****************************************************************************************************************************/
struct Matrix{

    int width;
    int height;
    double **data;
};

struct Matrix* createEmptyMatrix(int height, int width);

double** createEmptyTable(int, int);
double* createEmptyTable2(int);

void freeMatrix(struct Matrix *matrix);

void freeTable(double** table, int height);

void printMatrix( struct Matrix *matrix);

struct Matrix* add_Matrixes(SimStruct *S, struct Matrix *matrix_a, struct Matrix *matrix_b);

struct Matrix* substract_Matrixes(SimStruct *S, struct Matrix *matrix_a, struct Matrix *matrix_b);

void assertSameSize(SimStruct *S, struct Matrix *matrix_a, struct Matrix *matrix_b);

struct Matrix* multiply_Matrixes(SimStruct *S, struct Matrix *matrix_a, struct Matrix *matrix_b);

void assertSquare(struct Matrix *matrix);

struct Matrix* get_Transposed_Matrix(struct Matrix *matrix);

struct Matrix* create_diag_matrix(int size);

struct Matrix* invert2x2Matrix(SimStruct *S, struct Matrix *matrix);

//struct Matrix createMatrix(real_T **matrixData, int height, int width);

struct Matrix* createMatrixFromArray(real_T *vector, const int *dimension);

struct Matrix* createMatrixFromArrayC(const real_T *vector, const int *dimension);

struct Matrix dWorkToMatrix(real_T **dWork, int height, int width);

void freePWorkMemory(SimStruct *S);

void freeMatrixData(real_T **matrixData, int height, int width);

/*******************************************************************************************************************************
                                                    S-Funkcja
 *******************************************************************************************************************************/

/* Error handling
 * --------------
 *
 * You should use the following technique to report errors encountered within
 * an S-function:
 *
 *       ssSetErrorStatus(S,"Error encountered due to ...");
 *       return;
 *
 * Note that the 2nd argument to ssSetErrorStatus must be persistent memory.
 * It cannot be a local variable. For example the following will cause
 * unpredictable errors:
 *
 *      mdlOutputs()
 *      {
 *         char msg[256];         {ILLEGAL: to fix use "static char msg[256];"}
 *         sprintf(msg,"Error due to %s", string);
 *         ssSetErrorStatus(S,msg);
 *         return;
 *      }
 *
 */

/*====================*
 * S-function methods *
 *====================*/

/* Function: mdlInitializeSizes ===============================================
 * Abstract:
 *    The sizes information is used by Simulink to determine the S-function
 *    block's characteristics (number of inputs, outputs, states, etc.).
 */
static void mdlInitializeSizes(SimStruct *S)
{
    ssSetNumSFcnParams(S, 1);  /* Number of expected parameters */
    if (ssGetNumSFcnParams(S) != ssGetSFcnParamsCount(S)) {
        /* Return if number of expected != number of actual parameters */
        return;
    }

    ssSetNumContStates(S, 0);
    ssSetNumDiscStates(S, 4); // xHat

    if (!ssSetNumInputPorts(S, 2)) return;
    ssSetInputPortWidth(S, 0, 2);       // u
    ssSetInputPortRequiredContiguous(S, 0, true); /*direct input signal access*/
    ssSetInputPortWidth(S, 1, 2);       // y
    ssSetInputPortRequiredContiguous(S, 1, true); /*direct input signal access*/
    /*
     * Set direct feedthrough flag (1=yes, 0=no).
     * A port has direct feedthrough if the input is used in either
     * the mdlOutputs or mdlGetTimeOfNextVarHit functions.
     */
    ssSetInputPortDirectFeedThrough(S, 0, 1);
    ssSetInputPortDirectFeedThrough(S, 1, 1);
    //ssSetInputPortDirectFeedThrough(S, 1, 1);
    //ssSetInputPortDirectFeedThrough(S, 2, 1);
    //ssSetInputPortDirectFeedThrough(S, 3, 1);
    if (!ssSetNumOutputPorts(S, 1)) return;
    ssSetOutputPortWidth(S, 0, 4);
    ssSetNumSampleTimes(S, 1);
    ssSetNumRWork(S, 0);
    ssSetNumIWork(S, 0);
    
    ssSetNumPWork(S, 6);    //Ad, Bd, Cd, Z, V, P
    
    ssSetNumModes(S, 0);
    ssSetNumNonsampledZCs(S, 0);

    ssSetNumDWork(S, 0);   
	//ssSetDWorkWidth(S, 0, 1); //P1
    //ssSetDWorkWidth(S, 1, 1); //P2
    //ssSetDWorkWidth(S, 2, 1); //P3
    //ssSetDWorkWidth(S, 3, 1); //P4
    
    
    /* Specify the sim state compliance to be same as a built-in block */
    ssSetSimStateCompliance(S, USE_DEFAULT_SIM_STATE);

    ssSetOptions(S, 0);
}



/* Function: mdlInitializeSampleTimes =========================================
 * Abstract:
 *    This function is used to specify the sample time(s) for your
 *    S-function. You must register the same number of sample times as
 *    specified in ssSetNumSampleTimes.
 */
static void mdlInitializeSampleTimes(SimStruct *S)
{
    ssSetSampleTime(S, 0, CONTINUOUS_SAMPLE_TIME);
    ssSetOffsetTime(S, 0, 0.0);

}



#define MDL_INITIALIZE_CONDITIONS   /* Change to #undef to remove function */
#if defined(MDL_INITIALIZE_CONDITIONS)
  /* Function: mdlInitializeConditions ========================================
   * Abstract:
   *    In this function, you should initialize the continuous and discrete
   *    states for your S-function block.  The initial states are placed
   *    in the state vector, ssGetContStates(S) or ssGetRealDiscStates(S).
   *    You can also perform any other initialization activities that your
   *    S-function may require. Note, this routine will be called at the
   *    start of simulation and if it is present in an enabled subsystem
   *    configured to reset states, it will be call when the enabled subsystem
   *    restarts execution to reset the states.
   */
  static void mdlInitializeConditions(SimStruct *S)
  {       
      const mxArray *x0_mx = ssGetSFcnParam(S, 0);
      real_T *x0 = mxGetPr(x0_mx);      // Pobranie parametru z s-funkcij
      real_T *xHat = ssGetDiscStates(S);
      
      for(int_T i = 0; i < ssGetNumDiscStates(S); i++)      // zainicjowanie parametrów
      {
          xHat[i] = x0[i];    
      }
  }
#endif /* MDL_INITIALIZE_CONDITIONS */



#define MDL_START  /* Change to #undef to remove function */
#if defined(MDL_START) 
  /* Function: mdlStart =======================================================
   * Abstract:
   *    This function is called once at start of model execution. If you
   *    have states that should be initialized once, this is the place
   *    to do it.
   */
  static void mdlStart(SimStruct *S)
  {
      /* inicjalizacja macierzy stanu */
    //struct Matrix **dWork = (struct Matrix**)ssGetPWork(S);
    
    struct Matrix *Ad = createEmptyMatrix(4, 4);                                    // Stworzenie macierzy stanu
    Ad->data[0][0]=1; Ad->data[0][1]=0; Ad->data[0][2]=0.0001; Ad->data[0][3]=0;
    Ad->data[1][0]=0; Ad->data[1][1]=1; Ad->data[1][2]=0;      Ad->data[1][3]=0.0001;
    Ad->data[2][0]=0; Ad->data[2][1]=0; Ad->data[2][2]=1;      Ad->data[2][3]=0;
    Ad->data[3][0]=0; Ad->data[3][1]=0; Ad->data[3][2]=0;      Ad->data[3][3]=1;
    //dWork[0] = &Ad;
    ssSetPWorkValue(S,0,Ad);                                                        // przypisanie wskaŸnika na macierz do PWektora
    struct Matrix *Bd = createEmptyMatrix(4, 2);
    Bd->data[0][0]=0;      Bd->data[0][1]=0; 
    Bd->data[1][0]=0;      Bd->data[1][1]=0; 
    Bd->data[2][0]=0.0001; Bd->data[2][1]=0; 
    Bd->data[3][0]=0;      Bd->data[3][1]=0.0001; 
    //dWork[1] = &Bd;
    ssSetPWorkValue(S,1,Bd);
    struct Matrix *Cd = createEmptyMatrix(2, 4);
    Cd->data[0][0]=1; Cd->data[0][1]=0; Cd->data[0][2]=0; Cd->data[0][3]=0;
    Cd->data[1][0]=0; Cd->data[1][1]=1; Cd->data[1][2]=0; Cd->data[1][3]=0;
    //dWork[2] = &Cd;
    ssSetPWorkValue(S,2,Cd);
    struct Matrix *Z = createEmptyMatrix(2, 2);
    Z->data[0][0]=1; Z->data[0][1]=0; 
    Z->data[1][0]=0; Z->data[1][1]=1; 
    //dWork[3] = &Z;
    ssSetPWorkValue(S,3,Z);
    struct Matrix *V = createEmptyMatrix(2, 2);
    V->data[0][0]=1; V->data[0][1]=0; 
    V->data[1][0]=0; V->data[1][1]=1; 
    //dWork[4] = &V;
    ssSetPWorkValue(S,4,V);
    
	  /* Initializacja macierzy P */
      const mxArray *x0_mx = ssGetSFcnParam(S, 0);      // Pobranie parametru z bloczka s-funkcij
      real_T *x0 = mxGetPr(x0_mx);                      // Pobranie parametru z bloczka s-funkcij- stworzenie tabliczy
      const int *dimension_x0 = mxGetDimensions(x0_mx);                     // Pobranie wymiaru parametru bloczka s-funkcij
      struct Matrix *matrix_x0 = createMatrixFromArray(x0, dimension_x0);    // Stworzenie macierzy z wyci¹gnietej tablicy
      struct Matrix *matrix_x0T = get_Transposed_Matrix(matrix_x0);
                                          //testy
      struct Matrix *P0 = multiply_Matrixes(S, matrix_x0, matrix_x0T);
      
      //dWork[5] = &P0;
      ssSetPWorkValue(S,5,P0);
      /* czyszczenie pamiêci po inicjaci */
      freeMatrix(matrix_x0);               // Zwolnienie pamiêci
      freeMatrix(matrix_x0T);
  }
#endif /*  MDL_START */

/* Function: mdlOutputs   ========================================
 * Abstract:
 *    In this function, you compute the outputs of your S-function
 *    block.
 */

  
static void mdlOutputs(SimStruct *S, int_T tid)
{
    /*====================================================================================================================================
                                                            Stworzenie macierzy
    =====================================================================================================================================*/
    //struct Matrix **pWork = (struct Matrix**)ssGetPWork(S);
    struct Matrix *Ad = (struct Matrix*)ssGetPWorkValue(S, 0);
    struct Matrix *Bd = (struct Matrix*)ssGetPWorkValue(S, 1);
    struct Matrix *Cd = (struct Matrix*)ssGetPWorkValue(S, 2);
    struct Matrix *Z = (struct Matrix*)ssGetPWorkValue(S, 3);
    struct Matrix *V = (struct Matrix*)ssGetPWorkValue(S, 4);
    struct Matrix *P = (struct Matrix*)ssGetPWorkValue(S, 5);   
    
    real_T *xHat_p = ssGetDiscStates(S);
    const int dimension_xHat[2] = {4,1};
    struct Matrix *xHat = createMatrixFromArray(xHat_p, dimension_xHat);
    
    const real_T *u_p = (const real_T*) ssGetInputPortSignal(S,0);      // pomiar wejœcia
    const int dimension_u[2] = {2,1};
    struct Matrix *u = createMatrixFromArrayC(u_p, dimension_u);
    
    const real_T *y_p = (const real_T*) ssGetInputPortSignal(S,1);      // pomiar wyjœcia
    const int dimension_y[2] = {2,1};
    struct Matrix *y = createMatrixFromArrayC(y_p, dimension_y);
    
    real_T *estymaty = ssGetOutputPortSignal(S,0);                      // wyjœcie

    /*=====================================================================================================================================
                                                                Obliczenia
    ======================================================================================================================================*/                       
   
    
    
	ssPrintf("Szwank to noob \n");
	//ssSetErrorStatus(S, "main");
	/*const mxArray *vektor = ssGetSFcnParam(S, 0);
    real_T *tablica = mxGetPr(vektor);
    const int *dimension = mxGetDimensions(vektor);*/
    /*
    real_T** a = (real_T**)malloc(2*sizeof(real_T*));
    a[0] = (real_T*)malloc(2*sizeof(real_T));
    a[0][0] = 1; a[0][1] = 2;
    a[1] = (real_T*)malloc(2*sizeof(real_T));
    a[1][0] = 3; a[1][1] = 4;
    */
    
    // xHat_kk1:
    struct Matrix *xHat_kk1_1 = multiply_Matrixes(S, Ad, xHat); // Ad * x
    struct Matrix *xHat_kk1_2 = multiply_Matrixes(S, Bd, u);   // Bd * u
    struct Matrix *xHat_kk1 = add_Matrixes(S, xHat_kk1_1, xHat_kk1_2); // (Ad * x + Bd * (u+H))

    // P_kk1:
    struct Matrix *P_kk1_1 = multiply_Matrixes(S, Ad, P); // Ad * P
    struct Matrix *Ad_T = get_Transposed_Matrix(Ad);                                             // Ad'
    struct Matrix *P_kk1_2 = multiply_Matrixes(S, P_kk1_1, Ad_T); // Ad * P * Ad'
    struct Matrix *Bd_T = get_Transposed_Matrix(Bd);                                             // Bd'
    struct Matrix *P_kk1_3 = multiply_Matrixes(S, Bd, Z); // G * Z
    struct Matrix *P_kk1_4 = multiply_Matrixes(S, P_kk1_3, Bd_T); // G * Z * G'
    struct Matrix *P_kk1 = add_Matrixes(S, P_kk1_2, P_kk1_4); // P_kk1 = Ad * P * Ad' + G * Z * G'

    // K:
    struct Matrix *Cd_T = get_Transposed_Matrix(Cd);                                             // Cd'
    struct Matrix *K1 = multiply_Matrixes(S, Cd, P_kk1);            // Cd * P_kk1
    struct Matrix *K2 = multiply_Matrixes(S, K1, Cd_T);             // Cd * P_kk1 * Cd'
    struct Matrix *K3 = add_Matrixes(S, K2, V);                     // Cd * P_kk1 * Cd' + V
    struct Matrix *K4 = multiply_Matrixes(S, P_kk1, Cd_T);           // P_kk1 * Cd'
    struct Matrix *K3_inv = invert2x2Matrix(S, K3);
    struct Matrix *K = multiply_Matrixes(S, K4, K3_inv);  // K = P_kk1 * Cd' * inv(Cd * P_kk1 * Cd' + V)

    // P:
    struct Matrix *K_T = get_Transposed_Matrix(K);
    struct Matrix *P1 = multiply_Matrixes(S, K,V);                         // K * V
    struct Matrix *P2 = multiply_Matrixes(S, P1, K_T);                     // K * V * K'
    struct Matrix *diag4 = create_diag_matrix(4);                       // eye(4)
    struct Matrix *P3 = multiply_Matrixes(S, K, Cd);                       // K * Cd
    struct Matrix *P4 = substract_Matrixes(S, diag4, P3);                  // eye(4) - K * Cd
    struct Matrix *P4_T = get_Transposed_Matrix(P4);                    // (eye(4) - K * Cd)'
    struct Matrix *P5 = multiply_Matrixes(S, P4, P_kk1);                   // (eye(4) - K * Cd) * P_kk1
    struct Matrix *P6 = multiply_Matrixes(S, P5, P4_T);                     // (eye(4) - K * Cd) * P_kk1 * (eye(4) - K * Cd)'
    struct Matrix *P_obl = add_Matrixes(S, P6, P2);                        // (eye(4) - K * Cd) * P_kk1 * (eye(4) - K * Cd)' + K * V * K'
    ssSetPWorkValue(S, 5, P_obl);                                   // Zmiana wskaŸnika w PWorku
    freeMatrix(P);                                                  // Usuniêcie macierzy P
    
    // xHat:
    struct Matrix *xHat_1 = multiply_Matrixes(S, Cd, xHat_kk1);    // Cd * xHat_kk1
    struct Matrix *xHat_2 = substract_Matrixes(S, y, xHat_1);      // y - Cd * xHat_kk1
    struct Matrix *xHat_3 = multiply_Matrixes(S, K, xHat_2);       // K * [y - Cd * xHat_kk1]
    struct Matrix *xHat_obl = add_Matrixes(S, xHat_kk1, xHat_3);        // Hat_kk1 + K * [(y+F) - Cd * xHat_kk1]
    
    // wyprowadzenie wartoœci wyjœcia poza bloczek:
    estymaty[0] = xHat_obl->data[0][0];
    estymaty[1] = xHat_obl->data[1][0];
    estymaty[2] = xHat_obl->data[2][0];
    estymaty[3] = xHat_obl->data[3][0];
    
    
    // Sprz¹tniêcie ba³aganu:
    // xHat_kk1:
    freeMatrix(xHat_kk1_1);
    freeMatrix(xHat_kk1_2);
    freeMatrix(xHat_kk1);
    
    // P_kk1:
    freeMatrix(P_kk1_1);
    freeMatrix(Ad_T);
    freeMatrix(P_kk1_2);
    freeMatrix(Bd_T);
    freeMatrix(P_kk1_3);
    freeMatrix(P_kk1_4);
    freeMatrix(P_kk1);
    
    // K:
    freeMatrix(Cd_T);
    freeMatrix(K1);
    freeMatrix(K2);
    freeMatrix(K3);
    freeMatrix(K4);
    freeMatrix(K3_inv);
    freeMatrix(K);
    
    // P:
    freeMatrix(K_T);
    freeMatrix(P1);                   
    freeMatrix(P2);                   
    freeMatrix(diag4);                   
    freeMatrix(P3);                 
    freeMatrix(P4);               
    freeMatrix(P4_T);            
    freeMatrix(P5);        
    freeMatrix(P6);          
    
    // xHat:
    freeMatrix(xHat_1);  
    freeMatrix(xHat_2);   
    freeMatrix(xHat_3);    
/*

                  
block.Dwork(2).Data = P(1,:);       % aktualizacja P
block.Dwork(3).Data = P(2,:);
block.Dwork(4).Data = P(3,:);
block.Dwork(5).Data = P(4,:);
                  
% xHat:                  
block.OutputPort(1).Data = xHat_kk1 + K * (block.InputPort(2).Data + block.Dwork(7).Data - ...
                           Cd * xHat_kk1); % xHat_kk1 + K * [(y+F) - Cd * xHat_kk1]
                       

    */

    
    //free(a[0]);
    //free(a[1]);
    //free(a);
    
}



#define MDL_UPDATE  /* Change to #undef to remove function */
#if defined(MDL_UPDATE)
  /* Function: mdlUpdate ======================================================
   * Abstract:
   *    This function is called once for every major integration time step.
   *    Discrete states are typically updated here, but this function is useful
   *    for performing any tasks that should only take place once per
   *    integration step.
   */
  static void mdlUpdate(SimStruct *S, int_T tid)
  {
  }
#endif /* MDL_UPDATE */



#define MDL_DERIVATIVES  /* Change to #undef to remove function */
#if defined(MDL_DERIVATIVES)
  /* Function: mdlDerivatives =================================================
   * Abstract:
   *    In this function, you compute the S-function block's derivatives.
   *    The derivatives are placed in the derivative vector, ssGetdX(S).
   */
  static void mdlDerivatives(SimStruct *S)
  {
      real_T *dX = ssGetdX(S);
      real_T *X = ssGetDiscStates(S);
      
      for(int i = 0; i < 4; i++)
      {
          dX[i] = X[i];         // przepisanie zmiennych   
      }
      
  }
#endif /* MDL_DERIVATIVES */



/* Function: mdlTerminate =====================================================
 * Abstract:
 *    In this function, you should perform any actions that are necessary
 *    at the termination of a simulation.  For example, if memory was
 *    allocated in mdlStart, this is the place to free it.
 */
static void mdlTerminate(SimStruct *S)
{
    freePWorkMemory(S);
}

/******************************************************************************************************************************
                                                    Funkcje
 *****************************************************************************************************************************/

struct Matrix* createEmptyMatrix(int height, int width)
{
    struct Matrix *matrix = (struct Matrix*)malloc(sizeof(struct Matrix));
    matrix->width = width;
    matrix->height = height;
    matrix->data = createEmptyTable(height, width);
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

void printMatrix( struct Matrix *matrix)
{
    int i, j;
    for(i=0; i < matrix->height; i++)
    {
        for(j=0; j < matrix->width; j++)
			mexPrintf( "%f ", matrix->data[i][j]);
		mexPrintf( "\n");
    }
	mexPrintf( "\n");
	mexPrintf("  ..  \n");
}

void freeMatrix(struct Matrix *matrix)
{
    freeTable(matrix->data, matrix->height);
}

void freeTable(double** data, int height)
{
    int i;
    for(i=0; i<height; i++)
        free(data[i]);
    free(data);
}

struct Matrix* add_Matrixes(SimStruct *S, struct Matrix *matrix_a, struct Matrix *matrix_b )
{
    assertSameSize(S, matrix_a, matrix_b);

    struct Matrix *result = createEmptyMatrix(matrix_a->height, matrix_a->width);
    int i, j;
    for (i = 0; i < matrix_a->width; i++)
        for (j = 0; j < matrix_b->height; j++)
            result->data[j][i] = matrix_a->data[j][i] + matrix_b->data[j][i];

#if defined DEBUG
	printMatrix( result);
#endif

    return result;
}

struct Matrix* substract_Matrixes(SimStruct *S, struct Matrix *matrix_a, struct Matrix *matrix_b )
{
    assertSameSize(S, matrix_a, matrix_b);

    struct Matrix *result = createEmptyMatrix(matrix_a->height, matrix_a->width);


    int i, j;
    for (i = 0; i < matrix_a->width; i++)
        for (j = 0; j < matrix_b->height; j++)
            result->data[j][i] = matrix_a->data[j][i] - matrix_b->data[j][i];

#if defined DEBUG
	printMatrix( result);
#endif

    return result;
}

void assertSameSize(SimStruct *S, struct Matrix *matrix_a, struct Matrix *matrix_b)
{
    if (matrix_a->width != matrix_b->width ||
        matrix_a->height != matrix_b->height)
    {
        ssSetErrorStatus(S,"assertSameSize: The dimensions of the matrixes do not match");
        return;
    }

}

struct Matrix* multiply_Matrixes(SimStruct *S, struct Matrix *matrix_a, struct Matrix *matrix_b)
{
    if (matrix_a->width != matrix_b->height)
    {
        ssSetErrorStatus(S, "multiply_Matrixes: wymiary macierzy nie zgadzaj¹ siê");
        return;
    }

	struct Matrix *result = createEmptyMatrix(matrix_a->height, matrix_b->width);

    int i, j;
    for (i = 0; i < matrix_a->height; i++)
    {
        for (j = 0; j < matrix_b->width; j++)
        {
            double value = 0;
            int k;
            for (k = 0; k < matrix_b->height; k++)
                value += matrix_a->data[i][k] * matrix_b->data[k][j];

            result->data[i][j] = value;
        }
    }
    #if defined DEBUG
        printMatrix( result);
    #endif
        
    return result;
}




void assertSquare(struct Matrix *matrix)
{
    if (matrix->height != matrix->width )
    {
        printf("macierz nie jest kwadratowa");
        exit(0);
    }
}



struct Matrix* get_Transposed_Matrix(struct Matrix *matrix)
{
    struct Matrix *result = createEmptyMatrix(matrix->width, matrix->height);

    int i, j;
    for (i = 0; i < matrix->height; i++)
        for (j = 0; j < matrix->width; j++)
            result->data[j][i] = matrix->data[i][j];

#if defined DEBUG
	printMatrix( result);
#endif
    return result;
}




struct Matrix* create_diag_matrix(int size)
{
    struct Matrix *result  = createEmptyMatrix(size, size);

    int i, j;
    for (i = 0; i < size; i++)
        for (j = 0; j < size; j++)
            if(i == j)
                result->data[i][j] = 1;
            else
                result->data[i][j] = 0;

#if defined DEBUG
	printMatrix( result);
#endif

    return result;
}

struct Matrix* invert2x2Matrix(SimStruct *S, struct Matrix *matrix)
{
    if (matrix->height != 2 || matrix->width != 2)
    {
		ssSetErrorStatus(S, "Macierz nie ma wymiaru 2x2- odwracanie macierzy");
		return;
    }
    
    real_T determinant = matrix->data[0][0] * matrix->data[1][1] - matrix->data[0][1] * matrix->data[1][0];
    
    struct Matrix *invertedMatrix = createEmptyMatrix(2,2);
    
    invertedMatrix->data[0][0] = determinant * matrix->data[1][1];
    invertedMatrix->data[1][1] = determinant * matrix->data[0][0];
    invertedMatrix->data[1][0] = determinant * (- matrix->data[1][0]);
    invertedMatrix->data[0][1] = determinant * (- matrix->data[0][1]);

#if defined DEBUG
	printMatrix( invertedMatrix);
#endif
    
    return invertedMatrix;
}
// dalej nie zmienione na wskaŸniki//
/*struct Matrix createMatrix(real_T **matrixData, int height, int width)  // stworzenie macierzy z dynamicznej tablicy wskaŸników
{
    struct Matrix matrix;
    matrix.height = height;
    matrix.width  = width;
    matrix.data = matrixData;
    
    return matrix;
}*/

struct Matrix* createMatrixFromArray(real_T *vector, const int *dimension)  // stworzenie macierzy z tablicy
{
	struct Matrix *matrix = createEmptyMatrix(dimension[0], dimension[1]);

	for (int i = 0; i < matrix->height; i++)
	{
		for (int j = 0; j < matrix->width; j++)
		{

			matrix->data[i][j] = vector[i + matrix->height * j];
		}

	}

	return matrix;
}

struct Matrix* createMatrixFromArrayC(const real_T *vector, const int *dimension)  // stworzenie macierzy z tablicy
{
	struct Matrix *matrix = createEmptyMatrix(dimension[0], dimension[1]);

	for (int i = 0; i < matrix->height; i++)
	{
		for (int j = 0; j < matrix->width; j++)
		{

			matrix->data[i][j] = vector[i + matrix->height * j];
		}

	}

	return matrix;
}

struct Matrix dWorkToMatrixC(real_T **dWork, int height, int width)     //zak³¹dam ¿e macierz jest kwadratowa
{
    struct Matrix matrix;
    matrix.height = height;
    matrix.width = width;
    
    for(int i = 0; i < width; i++)
    {
        for(int j = 0; j < height; j++)
        {
         matrix.data[i][j] = dWork[i][j];   
        }
    }
    
    return matrix;
}

void freePWorkMemory(SimStruct *S)
{
    for(int i = 0; i < ssGetNumPWork(S); i++ )
    {
       struct Matrix *pointer = (struct Matrix*)ssGetPWorkValue(S, i);
       freeMatrix(pointer);  
    }
}

void freeMatrixData(real_T **matrixData, int height, int width)
{
    for(int i = 0; i < height; i++)
        free(matrixData[i]);
    
    free(matrixData);
}       

/*=============================*
 * Required S-function trailer *
 *=============================*/

#ifdef  MATLAB_MEX_FILE    /* Is this file being compiled as a MEX-file? */
#include "simulink.c"      /* MEX-file interface mechanism */
#else
#include "cg_sfun.h"       /* Code generation registration function */
#endif
