/* Include files */

#include "model_CharakterystykaStatyczna_sfun.h"
#include "c1_model_CharakterystykaStatyczna.h"
#define CHARTINSTANCE_CHARTNUMBER      (chartInstance->chartNumber)
#define CHARTINSTANCE_INSTANCENUMBER   (chartInstance->instanceNumber)
#include "model_CharakterystykaStatyczna_sfun_debug_macros.h"
#define _SF_MEX_LISTEN_FOR_CTRL_C(S)   sf_mex_listen_for_ctrl_c_with_debugger(S, sfGlobalDebugInstanceStruct);

static void chart_debug_initialization(SimStruct *S, unsigned int
  fullDebuggerInitialization);
static void chart_debug_initialize_data_addresses(SimStruct *S);
static const mxArray* sf_opaque_get_hover_data_for_msg(void *chartInstance,
  int32_T msgSSID);

/* Type Definitions */

/* Named Constants */
#define CALL_EVENT                     (-1)

/* Variable Declarations */

/* Variable Definitions */
static real_T _sfTime_;
static const char * c1_debug_family_names[6] = { "nargin", "nargout",
  "amplituda", "t", "czas", "y" };

/* Function Declarations */
static void initialize_c1_model_CharakterystykaStatyczna
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance);
static void initialize_params_c1_model_CharakterystykaStatyczna
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance);
static void enable_c1_model_CharakterystykaStatyczna
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance);
static void disable_c1_model_CharakterystykaStatyczna
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance);
static void c1_update_debugger_state_c1_model_CharakterystykaStatyczna
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance);
static const mxArray *get_sim_state_c1_model_CharakterystykaStatyczna
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance);
static void set_sim_state_c1_model_CharakterystykaStatyczna
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance, const
   mxArray *c1_st);
static void finalize_c1_model_CharakterystykaStatyczna
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance);
static void sf_gateway_c1_model_CharakterystykaStatyczna
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance);
static void mdl_start_c1_model_CharakterystykaStatyczna
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance);
static void initSimStructsc1_model_CharakterystykaStatyczna
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance);
static void init_script_number_translation(uint32_T c1_machineNumber, uint32_T
  c1_chartNumber, uint32_T c1_instanceNumber);
static const mxArray *c1_sf_marshallOut(void *chartInstanceVoid, void *c1_inData);
static real_T c1_emlrt_marshallIn
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance, const
   mxArray *c1_b_y, const char_T *c1_identifier);
static real_T c1_b_emlrt_marshallIn
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance, const
   mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId);
static void c1_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData);
static const mxArray *c1_b_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData);
static int32_T c1_c_emlrt_marshallIn
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance, const
   mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId);
static void c1_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData);
static uint8_T c1_d_emlrt_marshallIn
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance, const
   mxArray *c1_b_is_active_c1_model_CharakterystykaStatyczna, const char_T
   *c1_identifier);
static uint8_T c1_e_emlrt_marshallIn
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance, const
   mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId);
static void init_dsm_address_info
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance);
static void init_simulink_io_address
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance);

/* Function Definitions */
static void initialize_c1_model_CharakterystykaStatyczna
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance)
{
  if (sf_is_first_init_cond(chartInstance->S)) {
    initSimStructsc1_model_CharakterystykaStatyczna(chartInstance);
    chart_debug_initialize_data_addresses(chartInstance->S);
  }

  chartInstance->c1_sfEvent = CALL_EVENT;
  _sfTime_ = sf_get_time(chartInstance->S);
  chartInstance->c1_is_active_c1_model_CharakterystykaStatyczna = 0U;
}

static void initialize_params_c1_model_CharakterystykaStatyczna
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void enable_c1_model_CharakterystykaStatyczna
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void disable_c1_model_CharakterystykaStatyczna
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void c1_update_debugger_state_c1_model_CharakterystykaStatyczna
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static const mxArray *get_sim_state_c1_model_CharakterystykaStatyczna
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance)
{
  const mxArray *c1_st;
  const mxArray *c1_b_y = NULL;
  real_T c1_hoistedGlobal;
  const mxArray *c1_c_y = NULL;
  uint8_T c1_b_hoistedGlobal;
  const mxArray *c1_d_y = NULL;
  c1_st = NULL;
  c1_st = NULL;
  c1_b_y = NULL;
  sf_mex_assign(&c1_b_y, sf_mex_createcellmatrix(2, 1), false);
  c1_hoistedGlobal = *chartInstance->c1_y;
  c1_c_y = NULL;
  sf_mex_assign(&c1_c_y, sf_mex_create("y", &c1_hoistedGlobal, 0, 0U, 0U, 0U, 0),
                false);
  sf_mex_setcell(c1_b_y, 0, c1_c_y);
  c1_b_hoistedGlobal =
    chartInstance->c1_is_active_c1_model_CharakterystykaStatyczna;
  c1_d_y = NULL;
  sf_mex_assign(&c1_d_y, sf_mex_create("y", &c1_b_hoistedGlobal, 3, 0U, 0U, 0U,
    0), false);
  sf_mex_setcell(c1_b_y, 1, c1_d_y);
  sf_mex_assign(&c1_st, c1_b_y, false);
  return c1_st;
}

static void set_sim_state_c1_model_CharakterystykaStatyczna
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance, const
   mxArray *c1_st)
{
  const mxArray *c1_u;
  chartInstance->c1_doneDoubleBufferReInit = true;
  c1_u = sf_mex_dup(c1_st);
  *chartInstance->c1_y = c1_emlrt_marshallIn(chartInstance, sf_mex_dup
    (sf_mex_getcell("y", c1_u, 0)), "y");
  chartInstance->c1_is_active_c1_model_CharakterystykaStatyczna =
    c1_d_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(
    "is_active_c1_model_CharakterystykaStatyczna", c1_u, 1)),
    "is_active_c1_model_CharakterystykaStatyczna");
  sf_mex_destroy(&c1_u);
  c1_update_debugger_state_c1_model_CharakterystykaStatyczna(chartInstance);
  sf_mex_destroy(&c1_st);
}

static void finalize_c1_model_CharakterystykaStatyczna
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void sf_gateway_c1_model_CharakterystykaStatyczna
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance)
{
  real_T c1_hoistedGlobal;
  real_T c1_b_hoistedGlobal;
  real_T c1_c_hoistedGlobal;
  real_T c1_b_amplituda;
  real_T c1_b_t;
  real_T c1_b_czas;
  uint32_T c1_debug_family_var_map[6];
  real_T c1_nargin = 3.0;
  real_T c1_nargout = 1.0;
  real_T c1_b_y;
  real_T c1_A;
  real_T c1_x;
  real_T c1_b_x;
  real_T c1_b_A;
  real_T c1_c_x;
  real_T c1_d_x;
  real_T c1_c_A;
  real_T c1_e_x;
  real_T c1_f_x;
  real_T c1_d_A;
  real_T c1_g_x;
  real_T c1_h_x;
  _SFD_SYMBOL_SCOPE_PUSH(0U, 0U);
  _sfTime_ = sf_get_time(chartInstance->S);
  _SFD_CC_CALL(CHART_ENTER_SFUNCTION_TAG, 0U, chartInstance->c1_sfEvent);
  _SFD_DATA_RANGE_CHECK(*chartInstance->c1_czas, 2U, 1U, 0U,
                        chartInstance->c1_sfEvent, false);
  _SFD_DATA_RANGE_CHECK(*chartInstance->c1_t, 1U, 1U, 0U,
                        chartInstance->c1_sfEvent, false);
  _SFD_DATA_RANGE_CHECK(*chartInstance->c1_amplituda, 0U, 1U, 0U,
                        chartInstance->c1_sfEvent, false);
  chartInstance->c1_sfEvent = CALL_EVENT;
  _SFD_CC_CALL(CHART_ENTER_DURING_FUNCTION_TAG, 0U, chartInstance->c1_sfEvent);
  c1_hoistedGlobal = *chartInstance->c1_amplituda;
  c1_b_hoistedGlobal = *chartInstance->c1_t;
  c1_c_hoistedGlobal = *chartInstance->c1_czas;
  c1_b_amplituda = c1_hoistedGlobal;
  c1_b_t = c1_b_hoistedGlobal;
  c1_b_czas = c1_c_hoistedGlobal;
  _SFD_SYMBOL_SCOPE_PUSH_EML(0U, 6U, 6U, c1_debug_family_names,
    c1_debug_family_var_map);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c1_nargin, 0U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c1_nargout, 1U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c1_b_amplituda, 2U, c1_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c1_b_t, 3U, c1_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c1_b_czas, 4U, c1_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c1_b_y, 5U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  CV_EML_FCN(0, 0);
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 3);
  if (CV_EML_COND(0, 1, 0, CV_RELATIONAL_EVAL(4U, 0U, 0, c1_b_t, 0.16 *
        c1_b_czas, -1, 2U, c1_b_t < 0.16 * c1_b_czas)) || (CV_EML_COND(0, 1, 1,
        CV_RELATIONAL_EVAL(4U, 0U, 1, c1_b_t, 0.64 * c1_b_czas, -1, 5U, c1_b_t >=
         0.64 * c1_b_czas)) && CV_EML_COND(0, 1, 2, CV_RELATIONAL_EVAL(4U, 0U, 2,
         c1_b_t, 0.8 * c1_b_czas, -1, 2U, c1_b_t < 0.8 * c1_b_czas)))) {
    CV_EML_MCDC(0, 1, 0, true);
    CV_EML_IF(0, 1, 0, true);
    _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 4);
    c1_b_y = c1_b_amplituda;
    _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 5);
  } else {
    CV_EML_MCDC(0, 1, 0, false);
    CV_EML_IF(0, 1, 0, false);
    _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 6);
    if (CV_EML_COND(0, 1, 3, CV_RELATIONAL_EVAL(4U, 0U, 3, c1_b_t, 0.16 *
          c1_b_czas, -1, 5U, c1_b_t >= 0.16 * c1_b_czas)) && CV_EML_COND(0, 1, 4,
         CV_RELATIONAL_EVAL(4U, 0U, 4, c1_b_t, 0.28 * c1_b_czas, -1, 2U, c1_b_t <
          0.28 * c1_b_czas))) {
      CV_EML_MCDC(0, 1, 1, true);
      CV_EML_IF(0, 1, 1, true);
      _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 7);
      c1_A = c1_b_amplituda * 0.025;
      c1_x = c1_A;
      c1_b_x = c1_x;
      c1_b_y = c1_b_x / 0.065;
      _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 8);
    } else {
      CV_EML_MCDC(0, 1, 1, false);
      CV_EML_IF(0, 1, 1, false);
      _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 9);
      if (CV_EML_COND(0, 1, 5, CV_RELATIONAL_EVAL(4U, 0U, 5, c1_b_t, 0.28 *
            c1_b_czas, -1, 5U, c1_b_t >= 0.28 * c1_b_czas)) && CV_EML_COND(0, 1,
           6, CV_RELATIONAL_EVAL(4U, 0U, 6, c1_b_t, 0.48 * c1_b_czas, -1, 2U,
            c1_b_t < 0.48 * c1_b_czas))) {
        CV_EML_MCDC(0, 1, 2, true);
        CV_EML_IF(0, 1, 2, true);
        _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 10);
        c1_b_A = c1_b_amplituda * 0.05;
        c1_c_x = c1_b_A;
        c1_d_x = c1_c_x;
        c1_b_y = c1_d_x / 0.065;
        _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 11);
      } else {
        CV_EML_MCDC(0, 1, 2, false);
        CV_EML_IF(0, 1, 2, false);
        _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 12);
        if (CV_EML_COND(0, 1, 7, CV_RELATIONAL_EVAL(4U, 0U, 7, c1_b_t, 0.48 *
              c1_b_czas, -1, 5U, c1_b_t >= 0.48 * c1_b_czas)) && CV_EML_COND(0,
             1, 8, CV_RELATIONAL_EVAL(4U, 0U, 8, c1_b_t, 0.64 * c1_b_czas, -1,
              2U, c1_b_t < 0.64 * c1_b_czas))) {
          CV_EML_MCDC(0, 1, 3, true);
          CV_EML_IF(0, 1, 3, true);
          _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 13);
          c1_c_A = c1_b_amplituda * 0.04;
          c1_e_x = c1_c_A;
          c1_f_x = c1_e_x;
          c1_b_y = c1_f_x / 0.065;
          _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 14);
        } else {
          CV_EML_MCDC(0, 1, 3, false);
          CV_EML_IF(0, 1, 3, false);
          _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 15);
          if (CV_EML_COND(0, 1, 9, CV_RELATIONAL_EVAL(4U, 0U, 9, c1_b_t, 0.8 *
                c1_b_czas, -1, 5U, c1_b_t >= 0.8 * c1_b_czas)) && CV_EML_COND(0,
               1, 10, CV_RELATIONAL_EVAL(4U, 0U, 10, c1_b_t, c1_b_czas, -1, 2U,
                c1_b_t < c1_b_czas))) {
            CV_EML_MCDC(0, 1, 4, true);
            CV_EML_IF(0, 1, 4, true);
            _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 16);
            c1_d_A = c1_b_amplituda * 0.03;
            c1_g_x = c1_d_A;
            c1_h_x = c1_g_x;
            c1_b_y = c1_h_x / 0.065;
            _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 17);
          } else {
            CV_EML_MCDC(0, 1, 4, false);
            CV_EML_IF(0, 1, 4, false);
            _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 19);
            c1_b_y = 0.0;
          }
        }
      }
    }
  }

  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, -19);
  _SFD_SYMBOL_SCOPE_POP();
  *chartInstance->c1_y = c1_b_y;
  _SFD_CC_CALL(EXIT_OUT_OF_FUNCTION_TAG, 0U, chartInstance->c1_sfEvent);
  _SFD_SYMBOL_SCOPE_POP();
  _SFD_CHECK_FOR_STATE_INCONSISTENCY
    (_model_CharakterystykaStatycznaMachineNumber_, chartInstance->chartNumber,
     chartInstance->instanceNumber);
  _SFD_DATA_RANGE_CHECK(*chartInstance->c1_y, 3U, 1U, 0U,
                        chartInstance->c1_sfEvent, false);
}

static void mdl_start_c1_model_CharakterystykaStatyczna
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void initSimStructsc1_model_CharakterystykaStatyczna
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void init_script_number_translation(uint32_T c1_machineNumber, uint32_T
  c1_chartNumber, uint32_T c1_instanceNumber)
{
  (void)(c1_machineNumber);
  (void)(c1_chartNumber);
  (void)(c1_instanceNumber);
}

static const mxArray *c1_sf_marshallOut(void *chartInstanceVoid, void *c1_inData)
{
  const mxArray *c1_mxArrayOutData;
  real_T c1_u;
  const mxArray *c1_b_y = NULL;
  SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance;
  chartInstance = (SFc1_model_CharakterystykaStatycznaInstanceStruct *)
    chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  c1_mxArrayOutData = NULL;
  c1_u = *(real_T *)c1_inData;
  c1_b_y = NULL;
  sf_mex_assign(&c1_b_y, sf_mex_create("y", &c1_u, 0, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c1_mxArrayOutData, c1_b_y, false);
  return c1_mxArrayOutData;
}

static real_T c1_emlrt_marshallIn
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance, const
   mxArray *c1_b_y, const char_T *c1_identifier)
{
  real_T c1_c_y;
  emlrtMsgIdentifier c1_thisId;
  c1_thisId.fIdentifier = (const char *)c1_identifier;
  c1_thisId.fParent = NULL;
  c1_thisId.bParentIsCell = false;
  c1_c_y = c1_b_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_b_y), &c1_thisId);
  sf_mex_destroy(&c1_b_y);
  return c1_c_y;
}

static real_T c1_b_emlrt_marshallIn
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance, const
   mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId)
{
  real_T c1_b_y;
  real_T c1_d0;
  (void)chartInstance;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), &c1_d0, 1, 0, 0U, 0, 0U, 0);
  c1_b_y = c1_d0;
  sf_mex_destroy(&c1_u);
  return c1_b_y;
}

static void c1_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData)
{
  const mxArray *c1_b_y;
  const char_T *c1_identifier;
  emlrtMsgIdentifier c1_thisId;
  real_T c1_c_y;
  SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance;
  chartInstance = (SFc1_model_CharakterystykaStatycznaInstanceStruct *)
    chartInstanceVoid;
  c1_b_y = sf_mex_dup(c1_mxArrayInData);
  c1_identifier = c1_varName;
  c1_thisId.fIdentifier = (const char *)c1_identifier;
  c1_thisId.fParent = NULL;
  c1_thisId.bParentIsCell = false;
  c1_c_y = c1_b_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_b_y), &c1_thisId);
  sf_mex_destroy(&c1_b_y);
  *(real_T *)c1_outData = c1_c_y;
  sf_mex_destroy(&c1_mxArrayInData);
}

const mxArray
  *sf_c1_model_CharakterystykaStatyczna_get_eml_resolved_functions_info(void)
{
  const mxArray *c1_nameCaptureInfo = NULL;
  c1_nameCaptureInfo = NULL;
  sf_mex_assign(&c1_nameCaptureInfo, sf_mex_create("nameCaptureInfo", NULL, 0,
    0U, 1U, 0U, 2, 0, 1), false);
  return c1_nameCaptureInfo;
}

static const mxArray *c1_b_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData)
{
  const mxArray *c1_mxArrayOutData;
  int32_T c1_u;
  const mxArray *c1_b_y = NULL;
  SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance;
  chartInstance = (SFc1_model_CharakterystykaStatycznaInstanceStruct *)
    chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  c1_mxArrayOutData = NULL;
  c1_u = *(int32_T *)c1_inData;
  c1_b_y = NULL;
  sf_mex_assign(&c1_b_y, sf_mex_create("y", &c1_u, 6, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c1_mxArrayOutData, c1_b_y, false);
  return c1_mxArrayOutData;
}

static int32_T c1_c_emlrt_marshallIn
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance, const
   mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId)
{
  int32_T c1_b_y;
  int32_T c1_i0;
  (void)chartInstance;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), &c1_i0, 1, 6, 0U, 0, 0U, 0);
  c1_b_y = c1_i0;
  sf_mex_destroy(&c1_u);
  return c1_b_y;
}

static void c1_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData)
{
  const mxArray *c1_b_sfEvent;
  const char_T *c1_identifier;
  emlrtMsgIdentifier c1_thisId;
  int32_T c1_b_y;
  SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance;
  chartInstance = (SFc1_model_CharakterystykaStatycznaInstanceStruct *)
    chartInstanceVoid;
  c1_b_sfEvent = sf_mex_dup(c1_mxArrayInData);
  c1_identifier = c1_varName;
  c1_thisId.fIdentifier = (const char *)c1_identifier;
  c1_thisId.fParent = NULL;
  c1_thisId.bParentIsCell = false;
  c1_b_y = c1_c_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_b_sfEvent),
    &c1_thisId);
  sf_mex_destroy(&c1_b_sfEvent);
  *(int32_T *)c1_outData = c1_b_y;
  sf_mex_destroy(&c1_mxArrayInData);
}

static uint8_T c1_d_emlrt_marshallIn
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance, const
   mxArray *c1_b_is_active_c1_model_CharakterystykaStatyczna, const char_T
   *c1_identifier)
{
  uint8_T c1_b_y;
  emlrtMsgIdentifier c1_thisId;
  c1_thisId.fIdentifier = (const char *)c1_identifier;
  c1_thisId.fParent = NULL;
  c1_thisId.bParentIsCell = false;
  c1_b_y = c1_e_emlrt_marshallIn(chartInstance, sf_mex_dup
    (c1_b_is_active_c1_model_CharakterystykaStatyczna), &c1_thisId);
  sf_mex_destroy(&c1_b_is_active_c1_model_CharakterystykaStatyczna);
  return c1_b_y;
}

static uint8_T c1_e_emlrt_marshallIn
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance, const
   mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId)
{
  uint8_T c1_b_y;
  uint8_T c1_u0;
  (void)chartInstance;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), &c1_u0, 1, 3, 0U, 0, 0U, 0);
  c1_b_y = c1_u0;
  sf_mex_destroy(&c1_u);
  return c1_b_y;
}

static void init_dsm_address_info
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void init_simulink_io_address
  (SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance)
{
  chartInstance->c1_fEmlrtCtx = (void *)sfrtGetEmlrtCtx(chartInstance->S);
  chartInstance->c1_amplituda = (real_T *)ssGetInputPortSignal_wrapper
    (chartInstance->S, 0);
  chartInstance->c1_y = (real_T *)ssGetOutputPortSignal_wrapper(chartInstance->S,
    1);
  chartInstance->c1_t = (real_T *)ssGetInputPortSignal_wrapper(chartInstance->S,
    1);
  chartInstance->c1_czas = (real_T *)ssGetInputPortSignal_wrapper
    (chartInstance->S, 2);
}

/* SFunction Glue Code */
#ifdef utFree
#undef utFree
#endif

#ifdef utMalloc
#undef utMalloc
#endif

#ifdef __cplusplus

extern "C" void *utMalloc(size_t size);
extern "C" void utFree(void*);

#else

extern void *utMalloc(size_t size);
extern void utFree(void*);

#endif

void sf_c1_model_CharakterystykaStatyczna_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(51011615U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(1295138741U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(1935480290U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(427597098U);
}

mxArray* sf_c1_model_CharakterystykaStatyczna_get_post_codegen_info(void);
mxArray *sf_c1_model_CharakterystykaStatyczna_get_autoinheritance_info(void)
{
  const char *autoinheritanceFields[] = { "checksum", "inputs", "parameters",
    "outputs", "locals", "postCodegenInfo" };

  mxArray *mxAutoinheritanceInfo = mxCreateStructMatrix(1, 1, sizeof
    (autoinheritanceFields)/sizeof(autoinheritanceFields[0]),
    autoinheritanceFields);

  {
    mxArray *mxChecksum = mxCreateString("Hh2qoqtNDl8k7XxAnXl8bE");
    mxSetField(mxAutoinheritanceInfo,0,"checksum",mxChecksum);
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,3,3,dataFields);

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,0,mxREAL);
      double *pr = mxGetPr(mxSize);
      mxSetField(mxData,0,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt", "isFixedPointType" };

      mxArray *mxType = mxCreateStructMatrix(1,1,sizeof(typeFields)/sizeof
        (typeFields[0]),typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxType,0,"isFixedPointType",mxCreateDoubleScalar(0));
      mxSetField(mxData,0,"type",mxType);
    }

    mxSetField(mxData,0,"complexity",mxCreateDoubleScalar(0));

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,0,mxREAL);
      double *pr = mxGetPr(mxSize);
      mxSetField(mxData,1,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt", "isFixedPointType" };

      mxArray *mxType = mxCreateStructMatrix(1,1,sizeof(typeFields)/sizeof
        (typeFields[0]),typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxType,0,"isFixedPointType",mxCreateDoubleScalar(0));
      mxSetField(mxData,1,"type",mxType);
    }

    mxSetField(mxData,1,"complexity",mxCreateDoubleScalar(0));

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,0,mxREAL);
      double *pr = mxGetPr(mxSize);
      mxSetField(mxData,2,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt", "isFixedPointType" };

      mxArray *mxType = mxCreateStructMatrix(1,1,sizeof(typeFields)/sizeof
        (typeFields[0]),typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxType,0,"isFixedPointType",mxCreateDoubleScalar(0));
      mxSetField(mxData,2,"type",mxType);
    }

    mxSetField(mxData,2,"complexity",mxCreateDoubleScalar(0));
    mxSetField(mxAutoinheritanceInfo,0,"inputs",mxData);
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"parameters",mxCreateDoubleMatrix(0,0,
                mxREAL));
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,1,3,dataFields);

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,0,mxREAL);
      double *pr = mxGetPr(mxSize);
      mxSetField(mxData,0,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt", "isFixedPointType" };

      mxArray *mxType = mxCreateStructMatrix(1,1,sizeof(typeFields)/sizeof
        (typeFields[0]),typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxType,0,"isFixedPointType",mxCreateDoubleScalar(0));
      mxSetField(mxData,0,"type",mxType);
    }

    mxSetField(mxData,0,"complexity",mxCreateDoubleScalar(0));
    mxSetField(mxAutoinheritanceInfo,0,"outputs",mxData);
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"locals",mxCreateDoubleMatrix(0,0,mxREAL));
  }

  {
    mxArray* mxPostCodegenInfo =
      sf_c1_model_CharakterystykaStatyczna_get_post_codegen_info();
    mxSetField(mxAutoinheritanceInfo,0,"postCodegenInfo",mxPostCodegenInfo);
  }

  return(mxAutoinheritanceInfo);
}

mxArray *sf_c1_model_CharakterystykaStatyczna_third_party_uses_info(void)
{
  mxArray * mxcell3p = mxCreateCellMatrix(1,0);
  return(mxcell3p);
}

mxArray *sf_c1_model_CharakterystykaStatyczna_jit_fallback_info(void)
{
  const char *infoFields[] = { "fallbackType", "fallbackReason",
    "hiddenFallbackType", "hiddenFallbackReason", "incompatibleSymbol" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 5, infoFields);
  mxArray *fallbackType = mxCreateString("pre");
  mxArray *fallbackReason = mxCreateString("hasBreakpoints");
  mxArray *hiddenFallbackType = mxCreateString("none");
  mxArray *hiddenFallbackReason = mxCreateString("");
  mxArray *incompatibleSymbol = mxCreateString("");
  mxSetField(mxInfo, 0, infoFields[0], fallbackType);
  mxSetField(mxInfo, 0, infoFields[1], fallbackReason);
  mxSetField(mxInfo, 0, infoFields[2], hiddenFallbackType);
  mxSetField(mxInfo, 0, infoFields[3], hiddenFallbackReason);
  mxSetField(mxInfo, 0, infoFields[4], incompatibleSymbol);
  return mxInfo;
}

mxArray *sf_c1_model_CharakterystykaStatyczna_updateBuildInfo_args_info(void)
{
  mxArray *mxBIArgs = mxCreateCellMatrix(1,0);
  return mxBIArgs;
}

mxArray* sf_c1_model_CharakterystykaStatyczna_get_post_codegen_info(void)
{
  const char* fieldNames[] = { "exportedFunctionsUsedByThisChart",
    "exportedFunctionsChecksum" };

  mwSize dims[2] = { 1, 1 };

  mxArray* mxPostCodegenInfo = mxCreateStructArray(2, dims, sizeof(fieldNames)/
    sizeof(fieldNames[0]), fieldNames);

  {
    mxArray* mxExportedFunctionsChecksum = mxCreateString("");
    mwSize exp_dims[2] = { 0, 1 };

    mxArray* mxExportedFunctionsUsedByThisChart = mxCreateCellArray(2, exp_dims);
    mxSetField(mxPostCodegenInfo, 0, "exportedFunctionsUsedByThisChart",
               mxExportedFunctionsUsedByThisChart);
    mxSetField(mxPostCodegenInfo, 0, "exportedFunctionsChecksum",
               mxExportedFunctionsChecksum);
  }

  return mxPostCodegenInfo;
}

static const mxArray *sf_get_sim_state_info_c1_model_CharakterystykaStatyczna
  (void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  const char *infoEncStr[] = {
    "100 S1x2'type','srcId','name','auxInfo'{{M[1],M[5],T\"y\",},{M[8],M[0],T\"is_active_c1_model_CharakterystykaStatyczna\",}}"
  };

  mxArray *mxVarInfo = sf_mex_decode_encoded_mx_struct_array(infoEncStr, 2, 10);
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c1_model_CharakterystykaStatyczna_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static void chart_debug_initialization(SimStruct *S, unsigned int
  fullDebuggerInitialization)
{
  if (!sim_mode_is_rtw_gen(S)) {
    SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance =
      (SFc1_model_CharakterystykaStatycznaInstanceStruct *)
      sf_get_chart_instance_ptr(S);
    if (ssIsFirstInitCond(S) && fullDebuggerInitialization==1) {
      /* do this only if simulation is starting */
      {
        unsigned int chartAlreadyPresent;
        chartAlreadyPresent = sf_debug_initialize_chart
          (sfGlobalDebugInstanceStruct,
           _model_CharakterystykaStatycznaMachineNumber_,
           1,
           1,
           1,
           0,
           4,
           0,
           0,
           0,
           0,
           0,
           &chartInstance->chartNumber,
           &chartInstance->instanceNumber,
           (void *)S);

        /* Each instance must initialize its own list of scripts */
        init_script_number_translation
          (_model_CharakterystykaStatycznaMachineNumber_,
           chartInstance->chartNumber,chartInstance->instanceNumber);
        if (chartAlreadyPresent==0) {
          /* this is the first instance */
          sf_debug_set_chart_disable_implicit_casting
            (sfGlobalDebugInstanceStruct,
             _model_CharakterystykaStatycznaMachineNumber_,
             chartInstance->chartNumber,1);
          sf_debug_set_chart_event_thresholds(sfGlobalDebugInstanceStruct,
            _model_CharakterystykaStatycznaMachineNumber_,
            chartInstance->chartNumber,
            0,
            0,
            0);
          _SFD_SET_DATA_PROPS(0,1,1,0,"amplituda");
          _SFD_SET_DATA_PROPS(1,1,1,0,"t");
          _SFD_SET_DATA_PROPS(2,1,1,0,"czas");
          _SFD_SET_DATA_PROPS(3,2,0,1,"y");
          _SFD_STATE_INFO(0,0,2);
          _SFD_CH_SUBSTATE_COUNT(0);
          _SFD_CH_SUBSTATE_DECOMP(0);
        }

        _SFD_CV_INIT_CHART(0,0,0,0);

        {
          _SFD_CV_INIT_STATE(0,0,0,0,0,0,NULL,NULL);
        }

        _SFD_CV_INIT_TRANS(0,0,NULL,NULL,0,NULL);

        /* Initialization of MATLAB Function Model Coverage */
        _SFD_CV_INIT_EML(0,1,1,0,5,0,0,0,0,0,11,5);
        _SFD_CV_INIT_EML_FCN(0,0,"eML_blk_kernel",0,-1,433);
        _SFD_CV_INIT_EML_IF(0,1,0,36,88,111,154);
        _SFD_CV_INIT_EML_IF(0,1,1,111,152,189,428);
        _SFD_CV_INIT_EML_IF(0,1,2,189,231,267,428);
        _SFD_CV_INIT_EML_IF(0,1,3,267,310,346,428);
        _SFD_CV_INIT_EML_IF(0,1,4,346,389,-1,-2);

        {
          static int condStart[] = { 39, 53, 72 };

          static int condEnd[] = { 50, 68, 86 };

          static int pfixExpr[] = { 0, 1, 2, -3, -2 };

          _SFD_CV_INIT_EML_MCDC(0,1,0,39,87,3,0,&(condStart[0]),&(condEnd[0]),5,
                                &(pfixExpr[0]));
        }

        {
          static int condStart[] = { 120, 138 };

          static int condEnd[] = { 134, 151 };

          static int pfixExpr[] = { 0, 1, -3 };

          _SFD_CV_INIT_EML_MCDC(0,1,1,120,151,2,3,&(condStart[0]),&(condEnd[0]),
                                3,&(pfixExpr[0]));
        }

        {
          static int condStart[] = { 198, 216 };

          static int condEnd[] = { 212, 230 };

          static int pfixExpr[] = { 0, 1, -3 };

          _SFD_CV_INIT_EML_MCDC(0,1,2,198,230,2,5,&(condStart[0]),&(condEnd[0]),
                                3,&(pfixExpr[0]));
        }

        {
          static int condStart[] = { 276, 295 };

          static int condEnd[] = { 291, 309 };

          static int pfixExpr[] = { 0, 1, -3 };

          _SFD_CV_INIT_EML_MCDC(0,1,3,276,309,2,7,&(condStart[0]),&(condEnd[0]),
                                3,&(pfixExpr[0]));
        }

        {
          static int condStart[] = { 355, 374 };

          static int condEnd[] = { 370, 388 };

          static int pfixExpr[] = { 0, 1, -3 };

          _SFD_CV_INIT_EML_MCDC(0,1,4,355,388,2,9,&(condStart[0]),&(condEnd[0]),
                                3,&(pfixExpr[0]));
        }

        _SFD_CV_INIT_EML_RELATIONAL(0,1,0,39,50,-1,2);
        _SFD_CV_INIT_EML_RELATIONAL(0,1,1,53,68,-1,5);
        _SFD_CV_INIT_EML_RELATIONAL(0,1,2,72,86,-1,2);
        _SFD_CV_INIT_EML_RELATIONAL(0,1,3,120,134,-1,5);
        _SFD_CV_INIT_EML_RELATIONAL(0,1,4,138,151,-1,2);
        _SFD_CV_INIT_EML_RELATIONAL(0,1,5,198,212,-1,5);
        _SFD_CV_INIT_EML_RELATIONAL(0,1,6,216,230,-1,2);
        _SFD_CV_INIT_EML_RELATIONAL(0,1,7,276,291,-1,5);
        _SFD_CV_INIT_EML_RELATIONAL(0,1,8,295,309,-1,2);
        _SFD_CV_INIT_EML_RELATIONAL(0,1,9,355,370,-1,5);
        _SFD_CV_INIT_EML_RELATIONAL(0,1,10,374,388,-1,2);
        _SFD_SET_DATA_COMPILED_PROPS(0,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,0,
          (MexFcnForType)c1_sf_marshallOut,(MexInFcnForType)NULL);
        _SFD_SET_DATA_COMPILED_PROPS(1,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,0,
          (MexFcnForType)c1_sf_marshallOut,(MexInFcnForType)NULL);
        _SFD_SET_DATA_COMPILED_PROPS(2,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,0,
          (MexFcnForType)c1_sf_marshallOut,(MexInFcnForType)NULL);
        _SFD_SET_DATA_COMPILED_PROPS(3,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,0,
          (MexFcnForType)c1_sf_marshallOut,(MexInFcnForType)c1_sf_marshallIn);
      }
    } else {
      sf_debug_reset_current_state_configuration(sfGlobalDebugInstanceStruct,
        _model_CharakterystykaStatycznaMachineNumber_,chartInstance->chartNumber,
        chartInstance->instanceNumber);
    }
  }
}

static void chart_debug_initialize_data_addresses(SimStruct *S)
{
  if (!sim_mode_is_rtw_gen(S)) {
    SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance =
      (SFc1_model_CharakterystykaStatycznaInstanceStruct *)
      sf_get_chart_instance_ptr(S);
    if (ssIsFirstInitCond(S)) {
      /* do this only if simulation is starting and after we know the addresses of all data */
      {
        _SFD_SET_DATA_VALUE_PTR(0U, (void *)chartInstance->c1_amplituda);
        _SFD_SET_DATA_VALUE_PTR(3U, (void *)chartInstance->c1_y);
        _SFD_SET_DATA_VALUE_PTR(1U, (void *)chartInstance->c1_t);
        _SFD_SET_DATA_VALUE_PTR(2U, (void *)chartInstance->c1_czas);
      }
    }
  }
}

static const char* sf_get_instance_specialization(void)
{
  return "sTJwhVchFDhayqFcNs4YoiC";
}

static void sf_opaque_initialize_c1_model_CharakterystykaStatyczna(void
  *chartInstanceVar)
{
  chart_debug_initialization(((SFc1_model_CharakterystykaStatycznaInstanceStruct*)
    chartInstanceVar)->S,0);
  initialize_params_c1_model_CharakterystykaStatyczna
    ((SFc1_model_CharakterystykaStatycznaInstanceStruct*) chartInstanceVar);
  initialize_c1_model_CharakterystykaStatyczna
    ((SFc1_model_CharakterystykaStatycznaInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_enable_c1_model_CharakterystykaStatyczna(void
  *chartInstanceVar)
{
  enable_c1_model_CharakterystykaStatyczna
    ((SFc1_model_CharakterystykaStatycznaInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_disable_c1_model_CharakterystykaStatyczna(void
  *chartInstanceVar)
{
  disable_c1_model_CharakterystykaStatyczna
    ((SFc1_model_CharakterystykaStatycznaInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_gateway_c1_model_CharakterystykaStatyczna(void
  *chartInstanceVar)
{
  sf_gateway_c1_model_CharakterystykaStatyczna
    ((SFc1_model_CharakterystykaStatycznaInstanceStruct*) chartInstanceVar);
}

static const mxArray* sf_opaque_get_sim_state_c1_model_CharakterystykaStatyczna
  (SimStruct* S)
{
  return get_sim_state_c1_model_CharakterystykaStatyczna
    ((SFc1_model_CharakterystykaStatycznaInstanceStruct *)
     sf_get_chart_instance_ptr(S));    /* raw sim ctx */
}

static void sf_opaque_set_sim_state_c1_model_CharakterystykaStatyczna(SimStruct*
  S, const mxArray *st)
{
  set_sim_state_c1_model_CharakterystykaStatyczna
    ((SFc1_model_CharakterystykaStatycznaInstanceStruct*)
     sf_get_chart_instance_ptr(S), st);
}

static void sf_opaque_terminate_c1_model_CharakterystykaStatyczna(void
  *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc1_model_CharakterystykaStatycznaInstanceStruct*)
                    chartInstanceVar)->S;
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
      unload_model_CharakterystykaStatyczna_optimization_info();
    }

    finalize_c1_model_CharakterystykaStatyczna
      ((SFc1_model_CharakterystykaStatycznaInstanceStruct*) chartInstanceVar);
    utFree(chartInstanceVar);
    if (ssGetUserData(S)!= NULL) {
      sf_free_ChartRunTimeInfo(S);
    }

    ssSetUserData(S,NULL);
  }
}

static void sf_opaque_init_subchart_simstructs(void *chartInstanceVar)
{
  initSimStructsc1_model_CharakterystykaStatyczna
    ((SFc1_model_CharakterystykaStatycznaInstanceStruct*) chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c1_model_CharakterystykaStatyczna(SimStruct *S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  if (sf_machine_global_initializer_called()) {
    initialize_params_c1_model_CharakterystykaStatyczna
      ((SFc1_model_CharakterystykaStatycznaInstanceStruct*)
       sf_get_chart_instance_ptr(S));
  }
}

static void mdlSetWorkWidths_c1_model_CharakterystykaStatyczna(SimStruct *S)
{
  /* Set overwritable ports for inplace optimization */
  ssSetStatesModifiedOnlyInUpdate(S, 1);
  ssMdlUpdateIsEmpty(S, 1);
  if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
    mxArray *infoStruct = load_model_CharakterystykaStatyczna_optimization_info
      (sim_mode_is_rtw_gen(S), sim_mode_is_modelref_sim(S), sim_mode_is_external
       (S));
    int_T chartIsInlinable =
      (int_T)sf_is_chart_inlinable(sf_get_instance_specialization(),infoStruct,1);
    ssSetStateflowIsInlinable(S,chartIsInlinable);
    ssSetRTWCG(S,1);
    ssSetEnableFcnIsTrivial(S,1);
    ssSetDisableFcnIsTrivial(S,1);
    ssSetNotMultipleInlinable(S,sf_rtw_info_uint_prop
      (sf_get_instance_specialization(),infoStruct,1,
       "gatewayCannotBeInlinedMultipleTimes"));
    sf_set_chart_accesses_machine_info(S, sf_get_instance_specialization(),
      infoStruct, 1);
    sf_update_buildInfo(S, sf_get_instance_specialization(),infoStruct,1);
    if (chartIsInlinable) {
      ssSetInputPortOptimOpts(S, 0, SS_REUSABLE_AND_LOCAL);
      ssSetInputPortOptimOpts(S, 1, SS_REUSABLE_AND_LOCAL);
      ssSetInputPortOptimOpts(S, 2, SS_REUSABLE_AND_LOCAL);
      sf_mark_chart_expressionable_inputs(S,sf_get_instance_specialization(),
        infoStruct,1,3);
      sf_mark_chart_reusable_outputs(S,sf_get_instance_specialization(),
        infoStruct,1,1);
    }

    {
      unsigned int outPortIdx;
      for (outPortIdx=1; outPortIdx<=1; ++outPortIdx) {
        ssSetOutputPortOptimizeInIR(S, outPortIdx, 1U);
      }
    }

    {
      unsigned int inPortIdx;
      for (inPortIdx=0; inPortIdx < 3; ++inPortIdx) {
        ssSetInputPortOptimizeInIR(S, inPortIdx, 1U);
      }
    }

    sf_set_rtw_dwork_info(S,sf_get_instance_specialization(),infoStruct,1);
    sf_register_codegen_names_for_scoped_functions_defined_by_chart(S);
    ssSetHasSubFunctions(S,!(chartIsInlinable));
  } else {
  }

  ssSetOptions(S,ssGetOptions(S)|SS_OPTION_WORKS_WITH_CODE_REUSE);
  ssSetChecksum0(S,(3277772958U));
  ssSetChecksum1(S,(2820666077U));
  ssSetChecksum2(S,(2954521449U));
  ssSetChecksum3(S,(4137747653U));
  ssSetmdlDerivatives(S, NULL);
  ssSetExplicitFCSSCtrl(S,1);
  ssSetStateSemanticsClassicAndSynchronous(S, true);
  ssSupportsMultipleExecInstances(S,1);
}

static void mdlRTW_c1_model_CharakterystykaStatyczna(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlStart_c1_model_CharakterystykaStatyczna(SimStruct *S)
{
  SFc1_model_CharakterystykaStatycznaInstanceStruct *chartInstance;
  chartInstance = (SFc1_model_CharakterystykaStatycznaInstanceStruct *)utMalloc
    (sizeof(SFc1_model_CharakterystykaStatycznaInstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  memset(chartInstance, 0, sizeof
         (SFc1_model_CharakterystykaStatycznaInstanceStruct));
  chartInstance->chartInfo.chartInstance = chartInstance;
  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway =
    sf_opaque_gateway_c1_model_CharakterystykaStatyczna;
  chartInstance->chartInfo.initializeChart =
    sf_opaque_initialize_c1_model_CharakterystykaStatyczna;
  chartInstance->chartInfo.terminateChart =
    sf_opaque_terminate_c1_model_CharakterystykaStatyczna;
  chartInstance->chartInfo.enableChart =
    sf_opaque_enable_c1_model_CharakterystykaStatyczna;
  chartInstance->chartInfo.disableChart =
    sf_opaque_disable_c1_model_CharakterystykaStatyczna;
  chartInstance->chartInfo.getSimState =
    sf_opaque_get_sim_state_c1_model_CharakterystykaStatyczna;
  chartInstance->chartInfo.setSimState =
    sf_opaque_set_sim_state_c1_model_CharakterystykaStatyczna;
  chartInstance->chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c1_model_CharakterystykaStatyczna;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW = mdlRTW_c1_model_CharakterystykaStatyczna;
  chartInstance->chartInfo.mdlStart = mdlStart_c1_model_CharakterystykaStatyczna;
  chartInstance->chartInfo.mdlSetWorkWidths =
    mdlSetWorkWidths_c1_model_CharakterystykaStatyczna;
  chartInstance->chartInfo.callGetHoverDataForMsg = NULL;
  chartInstance->chartInfo.extModeExec = NULL;
  chartInstance->chartInfo.restoreLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.restoreBeforeLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.storeCurrentConfiguration = NULL;
  chartInstance->chartInfo.callAtomicSubchartUserFcn = NULL;
  chartInstance->chartInfo.callAtomicSubchartAutoFcn = NULL;
  chartInstance->chartInfo.debugInstance = sfGlobalDebugInstanceStruct;
  chartInstance->S = S;
  sf_init_ChartRunTimeInfo(S, &(chartInstance->chartInfo), false, 0);
  init_dsm_address_info(chartInstance);
  init_simulink_io_address(chartInstance);
  if (!sim_mode_is_rtw_gen(S)) {
  }

  chart_debug_initialization(S,1);
  mdl_start_c1_model_CharakterystykaStatyczna(chartInstance);
}

void c1_model_CharakterystykaStatyczna_method_dispatcher(SimStruct *S, int_T
  method, void *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_c1_model_CharakterystykaStatyczna(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c1_model_CharakterystykaStatyczna(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c1_model_CharakterystykaStatyczna(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c1_model_CharakterystykaStatyczna_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
