#ifndef __c2_eksperyment1_h__
#define __c2_eksperyment1_h__

/* Include files */
#include "sf_runtime/sfc_sf.h"
#include "sf_runtime/sfc_mex.h"
#include "rtwtypes.h"
#include "multiword_types.h"

/* Type Definitions */
#ifndef typedef_SFc2_eksperyment1InstanceStruct
#define typedef_SFc2_eksperyment1InstanceStruct

typedef struct {
  SimStruct *S;
  ChartInfoStruct chartInfo;
  uint32_T chartNumber;
  uint32_T instanceNumber;
  int32_T c2_sfEvent;
  boolean_T c2_doneDoubleBufferReInit;
  uint8_T c2_is_active_c2_eksperyment1;
  void *c2_fEmlrtCtx;
  real_T *c2_u1;
  real_T *c2_y1;
  real_T *c2_u2;
  real_T *c2_u3;
  real_T *c2_u4;
  real_T *c2_u5;
  real_T *c2_y2;
  real_T *c2_y3;
  real_T *c2_y4;
} SFc2_eksperyment1InstanceStruct;

#endif                                 /*typedef_SFc2_eksperyment1InstanceStruct*/

/* Named Constants */

/* Variable Declarations */
extern struct SfDebugInstanceStruct *sfGlobalDebugInstanceStruct;

/* Variable Definitions */

/* Function Declarations */
extern const mxArray *sf_c2_eksperyment1_get_eml_resolved_functions_info(void);

/* Function Definitions */
extern void sf_c2_eksperyment1_get_check_sum(mxArray *plhs[]);
extern void c2_eksperyment1_method_dispatcher(SimStruct *S, int_T method, void
  *data);

#endif
