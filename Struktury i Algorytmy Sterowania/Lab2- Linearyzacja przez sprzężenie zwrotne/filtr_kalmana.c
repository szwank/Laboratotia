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

/*
 * Need to include simstruc.h for the definition of the SimStruct and
 * its associated macro definitions.
 */
#include "simstruc.h"
#include "matrix.h"


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

    if (!ssSetNumInputPorts(S, 1)) return;
    ssSetInputPortWidth(S, 0, 1);
    ssSetInputPortRequiredContiguous(S, 0, true); /*direct input signal access*/
    /*
     * Set direct feedthrough flag (1=yes, 0=no).
     * A port has direct feedthrough if the input is used in either
     * the mdlOutputs or mdlGetTimeOfNextVarHit functions.
     */
    ssSetInputPortDirectFeedThrough(S, 0, 1);

    if (!ssSetNumOutputPorts(S, 1)) return;
    ssSetOutputPortWidth(S, 0, 1);

    ssSetNumSampleTimes(S, 1);
    ssSetNumRWork(S, 0);
    ssSetNumIWork(S, 0);
    ssSetNumPWork(S, 0);
    ssSetNumModes(S, 0);
    ssSetNumNonsampledZCs(S, 0);

    ssSetNumDWork(S, 4);   
	ssSetDWorkWidth(S, 0, 1); //P1
    ssSetDWorkWidth(S, 1, 1); //P2
    ssSetDWorkWidth(S, 2, 1); //P3
    ssSetDWorkWidth(S, 3, 1); //P4
    
    
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
	  /* Initializacja macierzy P */
      const mxArray *x0_mx = ssGetSFcnParam(S, 0);
      real_T *x0 = mxGetPr(x0_mx);      // Pobranie parametru z s-funkcij
      
      real_T P0[4][4];
      
      for(real_T i = 0; i < ssGetNumDiscStates(S); i++)
      {
       
          
          
          
      }
      
      P0 = block.DialogPrm(1).Data * block.DialogPrm(1).Data';   % P0
      block.Dwork(2).Data = P0(1,:);
      block.Dwork(3).Data = P0(2,:);
      block.Dwork(4).Data = P0(3,:);
      block.Dwork(5).Data = P0(4,:);
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
                                                            Zdefiniowanie macierzy
    =====================================================================================================================================*/
    
    static real_T Ad[4][4]={ { 1, 0, 0.0001, 0     } , // zdefiniowanie macierzy systemu dyskretnego po linearyzacij
                             { 0, 1, 0     , 0.0001} , // operator static- powoduje dodanie zmiennej do pamiêci globalnej
                             { 0, 0, 1     , 0     } ,
                             { 0, 0, 0     , 1     }
                           };
    static real_T Bd[4][2]={ { 0     , 0     } , // zdefiniowanie macierzy systemu dyskretnego po linearyzacij
                             { 0     , 0     } , // operator static- powoduje dodanie zmiennej do pamiêci globalnej
                             { 0.0001, 0     } ,
                             { 0     , 0.0001}
                           };
    static real_T Cd[2][4]={ { 1, 0, 0, 0} , // zdefiniowanie macierzy systemu dyskretnego po linearyzacij
                             { 0, 1, 0, 0}  // operator static- powoduje dodanie zmiennej do pamiêci globalnej                           
                           };                      
    
    static real_T G[4][2] = { { 0     , 0     } , // zdefiniowanie macierzy systemu dyskretnego po linearyzacij
                              { 0     , 0     } , // operator static- powoduje dodanie zmiennej do pamiêci globalnej
                              { 0.0001, 0     } ,
                              { 0     , 0.0001}
                            };
    
    static real_T Z[2][2]={ { 1     , 0     } , 
                            { 0     , 1     }  // operator static- powoduje dodanie zmiennej do pamiêci globalnej                             
                           };
    static real_T V[2][2]={ { 1     , 0     } , 
                            { 0     , 1     }  // operator static- powoduje dodanie zmiennej do pamiêci globalnej                             
                           };
    /*=====================================================================================================================================
                                                                Obliczenia
    ======================================================================================================================================*/                       
   
    const real_T *u = (const real_T*) ssGetInputPortSignal(S,0);
    real_T       *y = ssGetOutputPortSignal(S,0);
    
	//ssPrintf("Szwank to noob %f\n", *realPtr);
	const mxArray *vektor = ssGetSFcnParam(S, 0);
    real_T *tablica = mxGetPr(vektor);
    y[0] = tablica[0];
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
}


/*=============================*
 * Required S-function trailer *
 *=============================*/

#ifdef  MATLAB_MEX_FILE    /* Is this file being compiled as a MEX-file? */
#include "simulink.c"      /* MEX-file interface mechanism */
#else
#include "cg_sfun.h"       /* Code generation registration function */
#endif
