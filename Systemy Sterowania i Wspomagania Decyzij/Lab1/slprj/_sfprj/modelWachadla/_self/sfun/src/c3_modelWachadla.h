#ifndef __c3_modelWachadla_h__
#define __c3_modelWachadla_h__

/* Include files */
#include "sf_runtime/sfc_sf.h"
#include "sf_runtime/sfc_mex.h"
#include "rtwtypes.h"
#include "multiword_types.h"

/* Type Definitions */
#ifndef typedef_SFc3_modelWachadlaInstanceStruct
#define typedef_SFc3_modelWachadlaInstanceStruct

typedef struct {
  SimStruct *S;
  ChartInfoStruct chartInfo;
  uint32_T chartNumber;
  uint32_T instanceNumber;
  int32_T c3_sfEvent;
  boolean_T c3_doneDoubleBufferReInit;
  uint8_T c3_is_active_c3_modelWachadla;
  void *c3_fEmlrtCtx;
  real_T (*c3_u)[4];
  real_T (*c3_y)[4];
} SFc3_modelWachadlaInstanceStruct;

#endif                                 /*typedef_SFc3_modelWachadlaInstanceStruct*/

/* Named Constants */

/* Variable Declarations */
extern struct SfDebugInstanceStruct *sfGlobalDebugInstanceStruct;

/* Variable Definitions */

/* Function Declarations */
extern const mxArray *sf_c3_modelWachadla_get_eml_resolved_functions_info(void);

/* Function Definitions */
extern void sf_c3_modelWachadla_get_check_sum(mxArray *plhs[]);
extern void c3_modelWachadla_method_dispatcher(SimStruct *S, int_T method, void *
  data);

#endif
