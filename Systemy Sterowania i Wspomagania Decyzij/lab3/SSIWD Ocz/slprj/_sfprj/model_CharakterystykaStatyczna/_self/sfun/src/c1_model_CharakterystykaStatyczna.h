#ifndef __c1_model_CharakterystykaStatyczna_h__
#define __c1_model_CharakterystykaStatyczna_h__

/* Include files */
#include "sf_runtime/sfc_sf.h"
#include "sf_runtime/sfc_mex.h"
#include "rtwtypes.h"
#include "multiword_types.h"

/* Type Definitions */
#ifndef typedef_SFc1_model_CharakterystykaStatycznaInstanceStruct
#define typedef_SFc1_model_CharakterystykaStatycznaInstanceStruct

typedef struct {
  SimStruct *S;
  ChartInfoStruct chartInfo;
  uint32_T chartNumber;
  uint32_T instanceNumber;
  int32_T c1_sfEvent;
  boolean_T c1_doneDoubleBufferReInit;
  uint8_T c1_is_active_c1_model_CharakterystykaStatyczna;
  void *c1_fEmlrtCtx;
  real_T *c1_amplituda;
  real_T *c1_y;
  real_T *c1_t;
  real_T *c1_czas;
} SFc1_model_CharakterystykaStatycznaInstanceStruct;

#endif                                 /*typedef_SFc1_model_CharakterystykaStatycznaInstanceStruct*/

/* Named Constants */

/* Variable Declarations */
extern struct SfDebugInstanceStruct *sfGlobalDebugInstanceStruct;

/* Variable Definitions */

/* Function Declarations */
extern const mxArray
  *sf_c1_model_CharakterystykaStatyczna_get_eml_resolved_functions_info(void);

/* Function Definitions */
extern void sf_c1_model_CharakterystykaStatyczna_get_check_sum(mxArray *plhs[]);
extern void c1_model_CharakterystykaStatyczna_method_dispatcher(SimStruct *S,
  int_T method, void *data);

#endif
