/* Include files */

#include "modelWachadla_sfun.h"
#include "c1_modelWachadla.h"
#define CHARTINSTANCE_CHARTNUMBER      (chartInstance->chartNumber)
#define CHARTINSTANCE_INSTANCENUMBER   (chartInstance->instanceNumber)
#include "modelWachadla_sfun_debug_macros.h"
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
static const char * c1_debug_family_names[18] = { "A30", "B30", "A60", "B60",
  "A90", "B90", "A120", "B120", "A150", "B150", "A180", "B180", "A0", "B0",
  "nargin", "nargout", "u", "y" };

/* Function Declarations */
static void initialize_c1_modelWachadla(SFc1_modelWachadlaInstanceStruct
  *chartInstance);
static void initialize_params_c1_modelWachadla(SFc1_modelWachadlaInstanceStruct *
  chartInstance);
static void enable_c1_modelWachadla(SFc1_modelWachadlaInstanceStruct
  *chartInstance);
static void disable_c1_modelWachadla(SFc1_modelWachadlaInstanceStruct
  *chartInstance);
static void c1_update_debugger_state_c1_modelWachadla
  (SFc1_modelWachadlaInstanceStruct *chartInstance);
static const mxArray *get_sim_state_c1_modelWachadla
  (SFc1_modelWachadlaInstanceStruct *chartInstance);
static void set_sim_state_c1_modelWachadla(SFc1_modelWachadlaInstanceStruct
  *chartInstance, const mxArray *c1_st);
static void finalize_c1_modelWachadla(SFc1_modelWachadlaInstanceStruct
  *chartInstance);
static void sf_gateway_c1_modelWachadla(SFc1_modelWachadlaInstanceStruct
  *chartInstance);
static void mdl_start_c1_modelWachadla(SFc1_modelWachadlaInstanceStruct
  *chartInstance);
static void initSimStructsc1_modelWachadla(SFc1_modelWachadlaInstanceStruct
  *chartInstance);
static void init_script_number_translation(uint32_T c1_machineNumber, uint32_T
  c1_chartNumber, uint32_T c1_instanceNumber);
static const mxArray *c1_sf_marshallOut(void *chartInstanceVoid, void *c1_inData);
static void c1_emlrt_marshallIn(SFc1_modelWachadlaInstanceStruct *chartInstance,
  const mxArray *c1_b_y, const char_T *c1_identifier, real_T c1_c_y[16]);
static void c1_b_emlrt_marshallIn(SFc1_modelWachadlaInstanceStruct
  *chartInstance, const mxArray *c1_b_u, const emlrtMsgIdentifier *c1_parentId,
  real_T c1_b_y[16]);
static void c1_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData);
static const mxArray *c1_b_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData);
static const mxArray *c1_c_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData);
static real_T c1_c_emlrt_marshallIn(SFc1_modelWachadlaInstanceStruct
  *chartInstance, const mxArray *c1_b_u, const emlrtMsgIdentifier *c1_parentId);
static void c1_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData);
static const mxArray *c1_d_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData);
static void c1_d_emlrt_marshallIn(SFc1_modelWachadlaInstanceStruct
  *chartInstance, const mxArray *c1_b_u, const emlrtMsgIdentifier *c1_parentId,
  real_T c1_b_y[4]);
static void c1_c_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData);
static const mxArray *c1_e_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData);
static int32_T c1_e_emlrt_marshallIn(SFc1_modelWachadlaInstanceStruct
  *chartInstance, const mxArray *c1_b_u, const emlrtMsgIdentifier *c1_parentId);
static void c1_d_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData);
static uint8_T c1_f_emlrt_marshallIn(SFc1_modelWachadlaInstanceStruct
  *chartInstance, const mxArray *c1_b_is_active_c1_modelWachadla, const char_T
  *c1_identifier);
static uint8_T c1_g_emlrt_marshallIn(SFc1_modelWachadlaInstanceStruct
  *chartInstance, const mxArray *c1_b_u, const emlrtMsgIdentifier *c1_parentId);
static void init_dsm_address_info(SFc1_modelWachadlaInstanceStruct
  *chartInstance);
static void init_simulink_io_address(SFc1_modelWachadlaInstanceStruct
  *chartInstance);

/* Function Definitions */
static void initialize_c1_modelWachadla(SFc1_modelWachadlaInstanceStruct
  *chartInstance)
{
  if (sf_is_first_init_cond(chartInstance->S)) {
    initSimStructsc1_modelWachadla(chartInstance);
    chart_debug_initialize_data_addresses(chartInstance->S);
  }

  chartInstance->c1_sfEvent = CALL_EVENT;
  _sfTime_ = sf_get_time(chartInstance->S);
  chartInstance->c1_is_active_c1_modelWachadla = 0U;
}

static void initialize_params_c1_modelWachadla(SFc1_modelWachadlaInstanceStruct *
  chartInstance)
{
  (void)chartInstance;
}

static void enable_c1_modelWachadla(SFc1_modelWachadlaInstanceStruct
  *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void disable_c1_modelWachadla(SFc1_modelWachadlaInstanceStruct
  *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void c1_update_debugger_state_c1_modelWachadla
  (SFc1_modelWachadlaInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static const mxArray *get_sim_state_c1_modelWachadla
  (SFc1_modelWachadlaInstanceStruct *chartInstance)
{
  const mxArray *c1_st;
  const mxArray *c1_b_y = NULL;
  const mxArray *c1_c_y = NULL;
  uint8_T c1_hoistedGlobal;
  const mxArray *c1_d_y = NULL;
  c1_st = NULL;
  c1_st = NULL;
  c1_b_y = NULL;
  sf_mex_assign(&c1_b_y, sf_mex_createcellmatrix(2, 1), false);
  c1_c_y = NULL;
  sf_mex_assign(&c1_c_y, sf_mex_create("y", *chartInstance->c1_y, 0, 0U, 1U, 0U,
    2, 4, 4), false);
  sf_mex_setcell(c1_b_y, 0, c1_c_y);
  c1_hoistedGlobal = chartInstance->c1_is_active_c1_modelWachadla;
  c1_d_y = NULL;
  sf_mex_assign(&c1_d_y, sf_mex_create("y", &c1_hoistedGlobal, 3, 0U, 0U, 0U, 0),
                false);
  sf_mex_setcell(c1_b_y, 1, c1_d_y);
  sf_mex_assign(&c1_st, c1_b_y, false);
  return c1_st;
}

static void set_sim_state_c1_modelWachadla(SFc1_modelWachadlaInstanceStruct
  *chartInstance, const mxArray *c1_st)
{
  const mxArray *c1_b_u;
  real_T c1_dv0[16];
  int32_T c1_i0;
  chartInstance->c1_doneDoubleBufferReInit = true;
  c1_b_u = sf_mex_dup(c1_st);
  c1_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell("y", c1_b_u, 0)),
                      "y", c1_dv0);
  for (c1_i0 = 0; c1_i0 < 16; c1_i0++) {
    (*chartInstance->c1_y)[c1_i0] = c1_dv0[c1_i0];
  }

  chartInstance->c1_is_active_c1_modelWachadla = c1_f_emlrt_marshallIn
    (chartInstance, sf_mex_dup(sf_mex_getcell("is_active_c1_modelWachadla",
       c1_b_u, 1)), "is_active_c1_modelWachadla");
  sf_mex_destroy(&c1_b_u);
  c1_update_debugger_state_c1_modelWachadla(chartInstance);
  sf_mex_destroy(&c1_st);
}

static void finalize_c1_modelWachadla(SFc1_modelWachadlaInstanceStruct
  *chartInstance)
{
  (void)chartInstance;
}

static void sf_gateway_c1_modelWachadla(SFc1_modelWachadlaInstanceStruct
  *chartInstance)
{
  int32_T c1_i1;
  int32_T c1_i2;
  uint32_T c1_debug_family_var_map[18];
  real_T c1_b_u[7];
  real_T c1_A30[16];
  real_T c1_B30[4];
  real_T c1_A60[16];
  real_T c1_B60[4];
  real_T c1_A90[16];
  real_T c1_B90[4];
  real_T c1_A120[16];
  real_T c1_B120[4];
  real_T c1_A150[16];
  real_T c1_B150[4];
  real_T c1_A180[16];
  real_T c1_B180[4];
  real_T c1_A0[16];
  real_T c1_B0[4];
  real_T c1_nargin = 1.0;
  real_T c1_nargout = 1.0;
  real_T c1_b_y[16];
  int32_T c1_i3;
  int32_T c1_i4;
  static real_T c1_b[16] = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 82.175793755032018,
    84.210253293594022, 1.0, 0.0, -519.55044594189826, -205.32079760124526, 0.0,
    1.0, 0.0, 0.0 };

  static real_T c1_b_B30[4] = { 0.0, 0.0, 101.15074706956275, 39.973696930686465
  };

  int32_T c1_i5;
  int32_T c1_i6;
  static real_T c1_b_b[16] = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 28.966212288476232,
    51.413054029383787, 1.0, 0.0, -366.27351739584424, -83.56994425706921, 0.0,
    1.0, 0.0, 0.0 };

  static real_T c1_b_B60[4] = { 0.0, 0.0, 71.309417989662037, 16.270147317147313
  };

  int32_T c1_i7;
  int32_T c1_i8;
  static real_T c1_dv1[16] = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    2.3797125376456045E-15, 34.490170421005708, 1.0, 0.0, -319.19005207781623,
    -8.91876647545907E-15, 0.0, 1.0, 0.0, 0.0 };

  static real_T c1_b_B90[4] = { 0.0, 0.0, 62.142786089446183,
    1.7363855598201969E-15 };

  int32_T c1_i9;
  int32_T c1_i10;
  static real_T c1_c_b[16] = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -14.483106144238105,
    25.70652701469189, 1.0, 0.0, -366.27351739584418, 83.569944257069139, 0.0,
    1.0, 0.0, 0.0 };

  static real_T c1_b_B120[4] = { 0.0, 0.0, 71.309417989662023,
    -16.270147317147295 };

  int32_T c1_i11;
  int32_T c1_i12;
  static real_T c1_d_b[16] = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -16.4351587510064,
    16.8420506587188, 1.0, 0.0, -519.55044594189826, 205.32079760124526, 0.0,
    1.0, 0.0, 0.0 };

  static real_T c1_b_B150[4] = { 0.0, 0.0, 101.15074706956275,
    -39.973696930686465 };

  int32_T c1_i13;
  int32_T c1_i14;
  static real_T c1_dv2[16] = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    -0.040011417003596519, 0.035508787829527586, 1.0, 0.0, -657.02464475407453,
    299.81684657001358, 0.0, 1.0, 0.0, 0.0 };

  static real_T c1_b_B180[4] = { 0.0, 0.0, 127.91545879535407,
    -58.371036444050716 };

  int32_T c1_i15;
  int32_T c1_i16;
  static real_T c1_dv3[16] = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 125.65977907420324,
    111.5187748146256, 1.0, 0.0, -657.02534015806566, -299.81731380896423, 0.0,
    1.0, 0.0, 0.0 };

  static real_T c1_b_B0[4] = { 0.0, 0.0, 127.91559418284871, 58.371127410326046
  };

  int32_T c1_i17;
  int32_T c1_i18;
  real_T c1_a;
  int32_T c1_i19;
  int32_T c1_i20;
  real_T c1_e_b[16];
  real_T c1_b_a;
  int32_T c1_i21;
  real_T c1_c_a;
  real_T c1_c_y[16];
  int32_T c1_i22;
  real_T c1_d_a;
  real_T c1_d_y[16];
  int32_T c1_i23;
  real_T c1_e_a;
  real_T c1_e_y[16];
  static real_T c1_f_b[16] = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    34.490170421005708, 1.0, 0.0, -319.19005207781623, 0.0, 0.0, 1.0, 0.0, 0.0 };

  int32_T c1_i24;
  real_T c1_f_a;
  real_T c1_f_y[16];
  int32_T c1_i25;
  real_T c1_g_a;
  real_T c1_g_y[16];
  int32_T c1_i26;
  int32_T c1_i27;
  real_T c1_g_b[16];
  int32_T c1_i28;
  int32_T c1_i29;
  int32_T c1_i30;
  _SFD_SYMBOL_SCOPE_PUSH(0U, 0U);
  _sfTime_ = sf_get_time(chartInstance->S);
  _SFD_CC_CALL(CHART_ENTER_SFUNCTION_TAG, 0U, chartInstance->c1_sfEvent);
  for (c1_i1 = 0; c1_i1 < 7; c1_i1++) {
    _SFD_DATA_RANGE_CHECK((*chartInstance->c1_u)[c1_i1], 0U, 1U, 0U,
                          chartInstance->c1_sfEvent, false);
  }

  chartInstance->c1_sfEvent = CALL_EVENT;
  _SFD_CC_CALL(CHART_ENTER_DURING_FUNCTION_TAG, 0U, chartInstance->c1_sfEvent);
  for (c1_i2 = 0; c1_i2 < 7; c1_i2++) {
    c1_b_u[c1_i2] = (*chartInstance->c1_u)[c1_i2];
  }

  _SFD_SYMBOL_SCOPE_PUSH_EML(0U, 18U, 18U, c1_debug_family_names,
    c1_debug_family_var_map);
  _SFD_SYMBOL_SCOPE_ADD_EML(c1_A30, 0U, c1_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c1_B30, 1U, c1_d_sf_marshallOut,
    c1_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML(c1_A60, 2U, c1_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c1_B60, 3U, c1_d_sf_marshallOut,
    c1_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML(c1_A90, 4U, c1_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c1_B90, 5U, c1_d_sf_marshallOut,
    c1_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML(c1_A120, 6U, c1_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c1_B120, 7U, c1_d_sf_marshallOut,
    c1_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML(c1_A150, 8U, c1_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c1_B150, 9U, c1_d_sf_marshallOut,
    c1_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c1_A180, 10U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c1_B180, 11U, c1_d_sf_marshallOut,
    c1_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c1_A0, 12U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c1_B0, 13U, c1_d_sf_marshallOut,
    c1_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c1_nargin, 14U, c1_c_sf_marshallOut,
    c1_b_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c1_nargout, 15U, c1_c_sf_marshallOut,
    c1_b_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML(c1_b_u, 16U, c1_b_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c1_b_y, 17U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  CV_EML_FCN(0, 0);
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 3);
  for (c1_i3 = 0; c1_i3 < 16; c1_i3++) {
    c1_A30[c1_i3] = c1_b[c1_i3];
  }

  for (c1_i4 = 0; c1_i4 < 4; c1_i4++) {
    c1_B30[c1_i4] = c1_b_B30[c1_i4];
  }

  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 4);
  for (c1_i5 = 0; c1_i5 < 16; c1_i5++) {
    c1_A60[c1_i5] = c1_b_b[c1_i5];
  }

  for (c1_i6 = 0; c1_i6 < 4; c1_i6++) {
    c1_B60[c1_i6] = c1_b_B60[c1_i6];
  }

  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 5);
  for (c1_i7 = 0; c1_i7 < 16; c1_i7++) {
    c1_A90[c1_i7] = c1_dv1[c1_i7];
  }

  for (c1_i8 = 0; c1_i8 < 4; c1_i8++) {
    c1_B90[c1_i8] = c1_b_B90[c1_i8];
  }

  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 6);
  for (c1_i9 = 0; c1_i9 < 16; c1_i9++) {
    c1_A120[c1_i9] = c1_c_b[c1_i9];
  }

  for (c1_i10 = 0; c1_i10 < 4; c1_i10++) {
    c1_B120[c1_i10] = c1_b_B120[c1_i10];
  }

  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 7);
  for (c1_i11 = 0; c1_i11 < 16; c1_i11++) {
    c1_A150[c1_i11] = c1_d_b[c1_i11];
  }

  for (c1_i12 = 0; c1_i12 < 4; c1_i12++) {
    c1_B150[c1_i12] = c1_b_B150[c1_i12];
  }

  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 8);
  for (c1_i13 = 0; c1_i13 < 16; c1_i13++) {
    c1_A180[c1_i13] = c1_dv2[c1_i13];
  }

  for (c1_i14 = 0; c1_i14 < 4; c1_i14++) {
    c1_B180[c1_i14] = c1_b_B180[c1_i14];
  }

  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 10);
  for (c1_i15 = 0; c1_i15 < 16; c1_i15++) {
    c1_A0[c1_i15] = c1_dv3[c1_i15];
  }

  for (c1_i16 = 0; c1_i16 < 4; c1_i16++) {
    c1_B0[c1_i16] = c1_b_B0[c1_i16];
  }

  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 11);
  for (c1_i17 = 0; c1_i17 < 2; c1_i17++) {
    c1_A0[c1_i17 + 6] = 125.66 + -14.14 * (real_T)c1_i17;
  }

  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 12);
  c1_A90[6] = 0.0;
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 13);
  c1_A90[11] = 0.0;
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 14);
  for (c1_i18 = 0; c1_i18 < 2; c1_i18++) {
    c1_A180[c1_i18 + 6] = 0.0;
  }

  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 15);
  c1_B90[3] = 0.0;
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 18);
  c1_a = c1_b_u[0];
  for (c1_i19 = 0; c1_i19 < 16; c1_i19++) {
    c1_e_b[c1_i19] = c1_A0[c1_i19];
  }

  for (c1_i20 = 0; c1_i20 < 16; c1_i20++) {
    c1_e_b[c1_i20] *= c1_a;
  }

  c1_b_a = c1_b_u[1];
  for (c1_i21 = 0; c1_i21 < 16; c1_i21++) {
    c1_c_y[c1_i21] = c1_b_a * c1_b[c1_i21];
  }

  c1_c_a = c1_b_u[2];
  for (c1_i22 = 0; c1_i22 < 16; c1_i22++) {
    c1_d_y[c1_i22] = c1_c_a * c1_b_b[c1_i22];
  }

  c1_d_a = c1_b_u[3];
  for (c1_i23 = 0; c1_i23 < 16; c1_i23++) {
    c1_e_y[c1_i23] = c1_d_a * c1_f_b[c1_i23];
  }

  c1_e_a = c1_b_u[4];
  for (c1_i24 = 0; c1_i24 < 16; c1_i24++) {
    c1_f_y[c1_i24] = c1_e_a * c1_c_b[c1_i24];
  }

  c1_f_a = c1_b_u[5];
  for (c1_i25 = 0; c1_i25 < 16; c1_i25++) {
    c1_g_y[c1_i25] = c1_f_a * c1_d_b[c1_i25];
  }

  c1_g_a = c1_b_u[6];
  for (c1_i26 = 0; c1_i26 < 16; c1_i26++) {
    c1_g_b[c1_i26] = c1_A180[c1_i26];
  }

  for (c1_i27 = 0; c1_i27 < 16; c1_i27++) {
    c1_g_b[c1_i27] *= c1_g_a;
  }

  for (c1_i28 = 0; c1_i28 < 16; c1_i28++) {
    c1_b_y[c1_i28] = (((((c1_e_b[c1_i28] + c1_c_y[c1_i28]) + c1_d_y[c1_i28]) +
                        c1_e_y[c1_i28]) + c1_f_y[c1_i28]) + c1_g_y[c1_i28]) +
      c1_g_b[c1_i28];
  }

  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, -18);
  _SFD_SYMBOL_SCOPE_POP();
  for (c1_i29 = 0; c1_i29 < 16; c1_i29++) {
    (*chartInstance->c1_y)[c1_i29] = c1_b_y[c1_i29];
  }

  _SFD_CC_CALL(EXIT_OUT_OF_FUNCTION_TAG, 0U, chartInstance->c1_sfEvent);
  _SFD_SYMBOL_SCOPE_POP();
  _SFD_CHECK_FOR_STATE_INCONSISTENCY(_modelWachadlaMachineNumber_,
    chartInstance->chartNumber, chartInstance->instanceNumber);
  for (c1_i30 = 0; c1_i30 < 16; c1_i30++) {
    _SFD_DATA_RANGE_CHECK((*chartInstance->c1_y)[c1_i30], 1U, 1U, 0U,
                          chartInstance->c1_sfEvent, false);
  }
}

static void mdl_start_c1_modelWachadla(SFc1_modelWachadlaInstanceStruct
  *chartInstance)
{
  (void)chartInstance;
}

static void initSimStructsc1_modelWachadla(SFc1_modelWachadlaInstanceStruct
  *chartInstance)
{
  (void)chartInstance;
}

static void init_script_number_translation(uint32_T c1_machineNumber, uint32_T
  c1_chartNumber, uint32_T c1_instanceNumber)
{
  (void)(c1_machineNumber);
  (void)(c1_chartNumber);
  (void)(c1_instanceNumber);
  _SFD_SCRIPT_TRANSLATION(c1_chartNumber, c1_instanceNumber, 0U,
    sf_debug_get_script_id(
    "G:\\laboratoria\\Systemy Sterowania i Wspomagania Decyzij\\Lab1\\linearyzacja.m"));
}

static const mxArray *c1_sf_marshallOut(void *chartInstanceVoid, void *c1_inData)
{
  const mxArray *c1_mxArrayOutData;
  int32_T c1_i31;
  int32_T c1_i32;
  const mxArray *c1_b_y = NULL;
  int32_T c1_i33;
  real_T c1_b_u[16];
  SFc1_modelWachadlaInstanceStruct *chartInstance;
  chartInstance = (SFc1_modelWachadlaInstanceStruct *)chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  c1_mxArrayOutData = NULL;
  c1_i31 = 0;
  for (c1_i32 = 0; c1_i32 < 4; c1_i32++) {
    for (c1_i33 = 0; c1_i33 < 4; c1_i33++) {
      c1_b_u[c1_i33 + c1_i31] = (*(real_T (*)[16])c1_inData)[c1_i33 + c1_i31];
    }

    c1_i31 += 4;
  }

  c1_b_y = NULL;
  sf_mex_assign(&c1_b_y, sf_mex_create("y", c1_b_u, 0, 0U, 1U, 0U, 2, 4, 4),
                false);
  sf_mex_assign(&c1_mxArrayOutData, c1_b_y, false);
  return c1_mxArrayOutData;
}

static void c1_emlrt_marshallIn(SFc1_modelWachadlaInstanceStruct *chartInstance,
  const mxArray *c1_b_y, const char_T *c1_identifier, real_T c1_c_y[16])
{
  emlrtMsgIdentifier c1_thisId;
  c1_thisId.fIdentifier = (const char *)c1_identifier;
  c1_thisId.fParent = NULL;
  c1_thisId.bParentIsCell = false;
  c1_b_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_b_y), &c1_thisId, c1_c_y);
  sf_mex_destroy(&c1_b_y);
}

static void c1_b_emlrt_marshallIn(SFc1_modelWachadlaInstanceStruct
  *chartInstance, const mxArray *c1_b_u, const emlrtMsgIdentifier *c1_parentId,
  real_T c1_b_y[16])
{
  real_T c1_dv4[16];
  int32_T c1_i34;
  (void)chartInstance;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_b_u), c1_dv4, 1, 0, 0U, 1, 0U, 2, 4,
                4);
  for (c1_i34 = 0; c1_i34 < 16; c1_i34++) {
    c1_b_y[c1_i34] = c1_dv4[c1_i34];
  }

  sf_mex_destroy(&c1_b_u);
}

static void c1_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData)
{
  const mxArray *c1_b_y;
  const char_T *c1_identifier;
  emlrtMsgIdentifier c1_thisId;
  real_T c1_c_y[16];
  int32_T c1_i35;
  int32_T c1_i36;
  int32_T c1_i37;
  SFc1_modelWachadlaInstanceStruct *chartInstance;
  chartInstance = (SFc1_modelWachadlaInstanceStruct *)chartInstanceVoid;
  c1_b_y = sf_mex_dup(c1_mxArrayInData);
  c1_identifier = c1_varName;
  c1_thisId.fIdentifier = (const char *)c1_identifier;
  c1_thisId.fParent = NULL;
  c1_thisId.bParentIsCell = false;
  c1_b_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_b_y), &c1_thisId, c1_c_y);
  sf_mex_destroy(&c1_b_y);
  c1_i35 = 0;
  for (c1_i36 = 0; c1_i36 < 4; c1_i36++) {
    for (c1_i37 = 0; c1_i37 < 4; c1_i37++) {
      (*(real_T (*)[16])c1_outData)[c1_i37 + c1_i35] = c1_c_y[c1_i37 + c1_i35];
    }

    c1_i35 += 4;
  }

  sf_mex_destroy(&c1_mxArrayInData);
}

static const mxArray *c1_b_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData)
{
  const mxArray *c1_mxArrayOutData;
  int32_T c1_i38;
  const mxArray *c1_b_y = NULL;
  real_T c1_b_u[7];
  SFc1_modelWachadlaInstanceStruct *chartInstance;
  chartInstance = (SFc1_modelWachadlaInstanceStruct *)chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  c1_mxArrayOutData = NULL;
  for (c1_i38 = 0; c1_i38 < 7; c1_i38++) {
    c1_b_u[c1_i38] = (*(real_T (*)[7])c1_inData)[c1_i38];
  }

  c1_b_y = NULL;
  sf_mex_assign(&c1_b_y, sf_mex_create("y", c1_b_u, 0, 0U, 1U, 0U, 1, 7), false);
  sf_mex_assign(&c1_mxArrayOutData, c1_b_y, false);
  return c1_mxArrayOutData;
}

static const mxArray *c1_c_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData)
{
  const mxArray *c1_mxArrayOutData;
  real_T c1_b_u;
  const mxArray *c1_b_y = NULL;
  SFc1_modelWachadlaInstanceStruct *chartInstance;
  chartInstance = (SFc1_modelWachadlaInstanceStruct *)chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  c1_mxArrayOutData = NULL;
  c1_b_u = *(real_T *)c1_inData;
  c1_b_y = NULL;
  sf_mex_assign(&c1_b_y, sf_mex_create("y", &c1_b_u, 0, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c1_mxArrayOutData, c1_b_y, false);
  return c1_mxArrayOutData;
}

static real_T c1_c_emlrt_marshallIn(SFc1_modelWachadlaInstanceStruct
  *chartInstance, const mxArray *c1_b_u, const emlrtMsgIdentifier *c1_parentId)
{
  real_T c1_b_y;
  real_T c1_d0;
  (void)chartInstance;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_b_u), &c1_d0, 1, 0, 0U, 0, 0U, 0);
  c1_b_y = c1_d0;
  sf_mex_destroy(&c1_b_u);
  return c1_b_y;
}

static void c1_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData)
{
  const mxArray *c1_nargout;
  const char_T *c1_identifier;
  emlrtMsgIdentifier c1_thisId;
  real_T c1_b_y;
  SFc1_modelWachadlaInstanceStruct *chartInstance;
  chartInstance = (SFc1_modelWachadlaInstanceStruct *)chartInstanceVoid;
  c1_nargout = sf_mex_dup(c1_mxArrayInData);
  c1_identifier = c1_varName;
  c1_thisId.fIdentifier = (const char *)c1_identifier;
  c1_thisId.fParent = NULL;
  c1_thisId.bParentIsCell = false;
  c1_b_y = c1_c_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_nargout),
    &c1_thisId);
  sf_mex_destroy(&c1_nargout);
  *(real_T *)c1_outData = c1_b_y;
  sf_mex_destroy(&c1_mxArrayInData);
}

static const mxArray *c1_d_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData)
{
  const mxArray *c1_mxArrayOutData;
  int32_T c1_i39;
  const mxArray *c1_b_y = NULL;
  real_T c1_b_u[4];
  SFc1_modelWachadlaInstanceStruct *chartInstance;
  chartInstance = (SFc1_modelWachadlaInstanceStruct *)chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  c1_mxArrayOutData = NULL;
  for (c1_i39 = 0; c1_i39 < 4; c1_i39++) {
    c1_b_u[c1_i39] = (*(real_T (*)[4])c1_inData)[c1_i39];
  }

  c1_b_y = NULL;
  sf_mex_assign(&c1_b_y, sf_mex_create("y", c1_b_u, 0, 0U, 1U, 0U, 1, 4), false);
  sf_mex_assign(&c1_mxArrayOutData, c1_b_y, false);
  return c1_mxArrayOutData;
}

static void c1_d_emlrt_marshallIn(SFc1_modelWachadlaInstanceStruct
  *chartInstance, const mxArray *c1_b_u, const emlrtMsgIdentifier *c1_parentId,
  real_T c1_b_y[4])
{
  real_T c1_dv5[4];
  int32_T c1_i40;
  (void)chartInstance;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_b_u), c1_dv5, 1, 0, 0U, 1, 0U, 1, 4);
  for (c1_i40 = 0; c1_i40 < 4; c1_i40++) {
    c1_b_y[c1_i40] = c1_dv5[c1_i40];
  }

  sf_mex_destroy(&c1_b_u);
}

static void c1_c_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData)
{
  const mxArray *c1_B0;
  const char_T *c1_identifier;
  emlrtMsgIdentifier c1_thisId;
  real_T c1_b_y[4];
  int32_T c1_i41;
  SFc1_modelWachadlaInstanceStruct *chartInstance;
  chartInstance = (SFc1_modelWachadlaInstanceStruct *)chartInstanceVoid;
  c1_B0 = sf_mex_dup(c1_mxArrayInData);
  c1_identifier = c1_varName;
  c1_thisId.fIdentifier = (const char *)c1_identifier;
  c1_thisId.fParent = NULL;
  c1_thisId.bParentIsCell = false;
  c1_d_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_B0), &c1_thisId, c1_b_y);
  sf_mex_destroy(&c1_B0);
  for (c1_i41 = 0; c1_i41 < 4; c1_i41++) {
    (*(real_T (*)[4])c1_outData)[c1_i41] = c1_b_y[c1_i41];
  }

  sf_mex_destroy(&c1_mxArrayInData);
}

const mxArray *sf_c1_modelWachadla_get_eml_resolved_functions_info(void)
{
  const mxArray *c1_nameCaptureInfo = NULL;
  const char * c1_data[5] = {
    "789ce553cb4ac340149d4aad2da86421e2c24516ae0ddd487155697d146a115a5014c1497ab553339990a4b6e997b8f023fc00bfc3b5dfe1ca3c669a070c2914"
    "dd7861387372927b4e6e26a8d4b92c2184b683b516acaf0a8a6a2b06a4705c43d9caeb25098a5a47e5cc73427fe36830cb839917139358d09b501d9c805898c2",
    "a2cd90516261cb1bf83620075c66bec030521e89090342a1cb52e48204849ea5a40509a570df1a81f1dc9f50e48cdc24ae992628359f07c9fb970be693affc7c"
    "f2f709bf5749bf4a819fe8bf21f1ab716c64ae569b31aa1c158e071cf738ee70dc6f8a9cb62447d15c44ae4d494e25a78747033bfe1c1b631cf255bf8bf0abe4",
    "78e21f2b4336d14d48fcde57f4eb49fdb2fadde9fdf9b166629d39d8630ec15adf773da0bedaf7c061536c11ac12f5dab519c54f116b83e1cfc958eb62bdaea5"
    "e775488be7b5ecb992fde7355415dbe6f7c7e7c91ffa45f55ffc66927ecb9ebf5d899f92d3a7767ddaeedc0c1ad0e961ffc8657afbd66b2539ae0a7c8a722009",
    "ffedfe3f60016709", "" };

  c1_nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(c1_data, 1784U, &c1_nameCaptureInfo);
  return c1_nameCaptureInfo;
}

static const mxArray *c1_e_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData)
{
  const mxArray *c1_mxArrayOutData;
  int32_T c1_b_u;
  const mxArray *c1_b_y = NULL;
  SFc1_modelWachadlaInstanceStruct *chartInstance;
  chartInstance = (SFc1_modelWachadlaInstanceStruct *)chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  c1_mxArrayOutData = NULL;
  c1_b_u = *(int32_T *)c1_inData;
  c1_b_y = NULL;
  sf_mex_assign(&c1_b_y, sf_mex_create("y", &c1_b_u, 6, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c1_mxArrayOutData, c1_b_y, false);
  return c1_mxArrayOutData;
}

static int32_T c1_e_emlrt_marshallIn(SFc1_modelWachadlaInstanceStruct
  *chartInstance, const mxArray *c1_b_u, const emlrtMsgIdentifier *c1_parentId)
{
  int32_T c1_b_y;
  int32_T c1_i42;
  (void)chartInstance;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_b_u), &c1_i42, 1, 6, 0U, 0, 0U, 0);
  c1_b_y = c1_i42;
  sf_mex_destroy(&c1_b_u);
  return c1_b_y;
}

static void c1_d_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData)
{
  const mxArray *c1_b_sfEvent;
  const char_T *c1_identifier;
  emlrtMsgIdentifier c1_thisId;
  int32_T c1_b_y;
  SFc1_modelWachadlaInstanceStruct *chartInstance;
  chartInstance = (SFc1_modelWachadlaInstanceStruct *)chartInstanceVoid;
  c1_b_sfEvent = sf_mex_dup(c1_mxArrayInData);
  c1_identifier = c1_varName;
  c1_thisId.fIdentifier = (const char *)c1_identifier;
  c1_thisId.fParent = NULL;
  c1_thisId.bParentIsCell = false;
  c1_b_y = c1_e_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_b_sfEvent),
    &c1_thisId);
  sf_mex_destroy(&c1_b_sfEvent);
  *(int32_T *)c1_outData = c1_b_y;
  sf_mex_destroy(&c1_mxArrayInData);
}

static uint8_T c1_f_emlrt_marshallIn(SFc1_modelWachadlaInstanceStruct
  *chartInstance, const mxArray *c1_b_is_active_c1_modelWachadla, const char_T
  *c1_identifier)
{
  uint8_T c1_b_y;
  emlrtMsgIdentifier c1_thisId;
  c1_thisId.fIdentifier = (const char *)c1_identifier;
  c1_thisId.fParent = NULL;
  c1_thisId.bParentIsCell = false;
  c1_b_y = c1_g_emlrt_marshallIn(chartInstance, sf_mex_dup
    (c1_b_is_active_c1_modelWachadla), &c1_thisId);
  sf_mex_destroy(&c1_b_is_active_c1_modelWachadla);
  return c1_b_y;
}

static uint8_T c1_g_emlrt_marshallIn(SFc1_modelWachadlaInstanceStruct
  *chartInstance, const mxArray *c1_b_u, const emlrtMsgIdentifier *c1_parentId)
{
  uint8_T c1_b_y;
  uint8_T c1_u0;
  (void)chartInstance;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_b_u), &c1_u0, 1, 3, 0U, 0, 0U, 0);
  c1_b_y = c1_u0;
  sf_mex_destroy(&c1_b_u);
  return c1_b_y;
}

static void init_dsm_address_info(SFc1_modelWachadlaInstanceStruct
  *chartInstance)
{
  (void)chartInstance;
}

static void init_simulink_io_address(SFc1_modelWachadlaInstanceStruct
  *chartInstance)
{
  chartInstance->c1_fEmlrtCtx = (void *)sfrtGetEmlrtCtx(chartInstance->S);
  chartInstance->c1_u = (real_T (*)[7])ssGetInputPortSignal_wrapper
    (chartInstance->S, 0);
  chartInstance->c1_y = (real_T (*)[16])ssGetOutputPortSignal_wrapper
    (chartInstance->S, 1);
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

void sf_c1_modelWachadla_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(2576267158U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(3276708891U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(2387207471U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(3952461624U);
}

mxArray* sf_c1_modelWachadla_get_post_codegen_info(void);
mxArray *sf_c1_modelWachadla_get_autoinheritance_info(void)
{
  const char *autoinheritanceFields[] = { "checksum", "inputs", "parameters",
    "outputs", "locals", "postCodegenInfo" };

  mxArray *mxAutoinheritanceInfo = mxCreateStructMatrix(1, 1, sizeof
    (autoinheritanceFields)/sizeof(autoinheritanceFields[0]),
    autoinheritanceFields);

  {
    mxArray *mxChecksum = mxCreateString("3H9biIxGkoiVjUGvC5XGz");
    mxSetField(mxAutoinheritanceInfo,0,"checksum",mxChecksum);
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,1,3,dataFields);

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,1,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(7);
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
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(4);
      pr[1] = (double)(4);
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
    mxArray* mxPostCodegenInfo = sf_c1_modelWachadla_get_post_codegen_info();
    mxSetField(mxAutoinheritanceInfo,0,"postCodegenInfo",mxPostCodegenInfo);
  }

  return(mxAutoinheritanceInfo);
}

mxArray *sf_c1_modelWachadla_third_party_uses_info(void)
{
  mxArray * mxcell3p = mxCreateCellMatrix(1,0);
  return(mxcell3p);
}

mxArray *sf_c1_modelWachadla_jit_fallback_info(void)
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

mxArray *sf_c1_modelWachadla_updateBuildInfo_args_info(void)
{
  mxArray *mxBIArgs = mxCreateCellMatrix(1,0);
  return mxBIArgs;
}

mxArray* sf_c1_modelWachadla_get_post_codegen_info(void)
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

static const mxArray *sf_get_sim_state_info_c1_modelWachadla(void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  const char *infoEncStr[] = {
    "100 S1x2'type','srcId','name','auxInfo'{{M[1],M[5],T\"y\",},{M[8],M[0],T\"is_active_c1_modelWachadla\",}}"
  };

  mxArray *mxVarInfo = sf_mex_decode_encoded_mx_struct_array(infoEncStr, 2, 10);
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c1_modelWachadla_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static void chart_debug_initialization(SimStruct *S, unsigned int
  fullDebuggerInitialization)
{
  if (!sim_mode_is_rtw_gen(S)) {
    SFc1_modelWachadlaInstanceStruct *chartInstance =
      (SFc1_modelWachadlaInstanceStruct *)sf_get_chart_instance_ptr(S);
    if (ssIsFirstInitCond(S) && fullDebuggerInitialization==1) {
      /* do this only if simulation is starting */
      {
        unsigned int chartAlreadyPresent;
        chartAlreadyPresent = sf_debug_initialize_chart
          (sfGlobalDebugInstanceStruct,
           _modelWachadlaMachineNumber_,
           1,
           1,
           1,
           0,
           2,
           0,
           0,
           0,
           0,
           1,
           &chartInstance->chartNumber,
           &chartInstance->instanceNumber,
           (void *)S);

        /* Each instance must initialize its own list of scripts */
        init_script_number_translation(_modelWachadlaMachineNumber_,
          chartInstance->chartNumber,chartInstance->instanceNumber);
        if (chartAlreadyPresent==0) {
          /* this is the first instance */
          sf_debug_set_chart_disable_implicit_casting
            (sfGlobalDebugInstanceStruct,_modelWachadlaMachineNumber_,
             chartInstance->chartNumber,1);
          sf_debug_set_chart_event_thresholds(sfGlobalDebugInstanceStruct,
            _modelWachadlaMachineNumber_,
            chartInstance->chartNumber,
            0,
            0,
            0);
          _SFD_SET_DATA_PROPS(0,1,1,0,"u");
          _SFD_SET_DATA_PROPS(1,2,0,1,"y");
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
        _SFD_CV_INIT_EML(0,1,1,0,0,0,0,0,0,0,0,0);
        _SFD_CV_INIT_EML_FCN(0,0,"eML_blk_kernel",0,-1,537);
        _SFD_CV_INIT_SCRIPT(0,1,0,0,0,0,0,0,0,0,0);
        _SFD_CV_INIT_SCRIPT_FCN(0,0,"linearyzacja",0,-1,1509);

        {
          unsigned int dimVector[1];
          dimVector[0]= 7U;
          _SFD_SET_DATA_COMPILED_PROPS(0,SF_DOUBLE,1,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c1_b_sf_marshallOut,(MexInFcnForType)NULL);
        }

        {
          unsigned int dimVector[2];
          dimVector[0]= 4U;
          dimVector[1]= 4U;
          _SFD_SET_DATA_COMPILED_PROPS(1,SF_DOUBLE,2,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c1_sf_marshallOut,(MexInFcnForType)
            c1_sf_marshallIn);
        }
      }
    } else {
      sf_debug_reset_current_state_configuration(sfGlobalDebugInstanceStruct,
        _modelWachadlaMachineNumber_,chartInstance->chartNumber,
        chartInstance->instanceNumber);
    }
  }
}

static void chart_debug_initialize_data_addresses(SimStruct *S)
{
  if (!sim_mode_is_rtw_gen(S)) {
    SFc1_modelWachadlaInstanceStruct *chartInstance =
      (SFc1_modelWachadlaInstanceStruct *)sf_get_chart_instance_ptr(S);
    if (ssIsFirstInitCond(S)) {
      /* do this only if simulation is starting and after we know the addresses of all data */
      {
        _SFD_SET_DATA_VALUE_PTR(0U, (void *)chartInstance->c1_u);
        _SFD_SET_DATA_VALUE_PTR(1U, (void *)chartInstance->c1_y);
      }
    }
  }
}

static const char* sf_get_instance_specialization(void)
{
  return "sWIe15Gdwd4NgWYnpcBEhaG";
}

static void sf_opaque_initialize_c1_modelWachadla(void *chartInstanceVar)
{
  chart_debug_initialization(((SFc1_modelWachadlaInstanceStruct*)
    chartInstanceVar)->S,0);
  initialize_params_c1_modelWachadla((SFc1_modelWachadlaInstanceStruct*)
    chartInstanceVar);
  initialize_c1_modelWachadla((SFc1_modelWachadlaInstanceStruct*)
    chartInstanceVar);
}

static void sf_opaque_enable_c1_modelWachadla(void *chartInstanceVar)
{
  enable_c1_modelWachadla((SFc1_modelWachadlaInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_disable_c1_modelWachadla(void *chartInstanceVar)
{
  disable_c1_modelWachadla((SFc1_modelWachadlaInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_gateway_c1_modelWachadla(void *chartInstanceVar)
{
  sf_gateway_c1_modelWachadla((SFc1_modelWachadlaInstanceStruct*)
    chartInstanceVar);
}

static const mxArray* sf_opaque_get_sim_state_c1_modelWachadla(SimStruct* S)
{
  return get_sim_state_c1_modelWachadla((SFc1_modelWachadlaInstanceStruct *)
    sf_get_chart_instance_ptr(S));     /* raw sim ctx */
}

static void sf_opaque_set_sim_state_c1_modelWachadla(SimStruct* S, const mxArray
  *st)
{
  set_sim_state_c1_modelWachadla((SFc1_modelWachadlaInstanceStruct*)
    sf_get_chart_instance_ptr(S), st);
}

static void sf_opaque_terminate_c1_modelWachadla(void *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc1_modelWachadlaInstanceStruct*) chartInstanceVar)->S;
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
      unload_modelWachadla_optimization_info();
    }

    finalize_c1_modelWachadla((SFc1_modelWachadlaInstanceStruct*)
      chartInstanceVar);
    utFree(chartInstanceVar);
    if (ssGetUserData(S)!= NULL) {
      sf_free_ChartRunTimeInfo(S);
    }

    ssSetUserData(S,NULL);
  }
}

static void sf_opaque_init_subchart_simstructs(void *chartInstanceVar)
{
  initSimStructsc1_modelWachadla((SFc1_modelWachadlaInstanceStruct*)
    chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c1_modelWachadla(SimStruct *S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  if (sf_machine_global_initializer_called()) {
    initialize_params_c1_modelWachadla((SFc1_modelWachadlaInstanceStruct*)
      sf_get_chart_instance_ptr(S));
  }
}

static void mdlSetWorkWidths_c1_modelWachadla(SimStruct *S)
{
  /* Set overwritable ports for inplace optimization */
  ssSetStatesModifiedOnlyInUpdate(S, 1);
  ssMdlUpdateIsEmpty(S, 1);
  if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
    mxArray *infoStruct = load_modelWachadla_optimization_info
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
      sf_mark_chart_expressionable_inputs(S,sf_get_instance_specialization(),
        infoStruct,1,1);
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
      for (inPortIdx=0; inPortIdx < 1; ++inPortIdx) {
        ssSetInputPortOptimizeInIR(S, inPortIdx, 1U);
      }
    }

    sf_set_rtw_dwork_info(S,sf_get_instance_specialization(),infoStruct,1);
    sf_register_codegen_names_for_scoped_functions_defined_by_chart(S);
    ssSetHasSubFunctions(S,!(chartIsInlinable));
  } else {
  }

  ssSetOptions(S,ssGetOptions(S)|SS_OPTION_WORKS_WITH_CODE_REUSE);
  ssSetChecksum0(S,(205398438U));
  ssSetChecksum1(S,(1934435639U));
  ssSetChecksum2(S,(2961891149U));
  ssSetChecksum3(S,(1495959973U));
  ssSetmdlDerivatives(S, NULL);
  ssSetExplicitFCSSCtrl(S,1);
  ssSetStateSemanticsClassicAndSynchronous(S, true);
  ssSupportsMultipleExecInstances(S,1);
}

static void mdlRTW_c1_modelWachadla(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlStart_c1_modelWachadla(SimStruct *S)
{
  SFc1_modelWachadlaInstanceStruct *chartInstance;
  chartInstance = (SFc1_modelWachadlaInstanceStruct *)utMalloc(sizeof
    (SFc1_modelWachadlaInstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  memset(chartInstance, 0, sizeof(SFc1_modelWachadlaInstanceStruct));
  chartInstance->chartInfo.chartInstance = chartInstance;
  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway = sf_opaque_gateway_c1_modelWachadla;
  chartInstance->chartInfo.initializeChart =
    sf_opaque_initialize_c1_modelWachadla;
  chartInstance->chartInfo.terminateChart = sf_opaque_terminate_c1_modelWachadla;
  chartInstance->chartInfo.enableChart = sf_opaque_enable_c1_modelWachadla;
  chartInstance->chartInfo.disableChart = sf_opaque_disable_c1_modelWachadla;
  chartInstance->chartInfo.getSimState =
    sf_opaque_get_sim_state_c1_modelWachadla;
  chartInstance->chartInfo.setSimState =
    sf_opaque_set_sim_state_c1_modelWachadla;
  chartInstance->chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c1_modelWachadla;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW = mdlRTW_c1_modelWachadla;
  chartInstance->chartInfo.mdlStart = mdlStart_c1_modelWachadla;
  chartInstance->chartInfo.mdlSetWorkWidths = mdlSetWorkWidths_c1_modelWachadla;
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
  mdl_start_c1_modelWachadla(chartInstance);
}

void c1_modelWachadla_method_dispatcher(SimStruct *S, int_T method, void *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_c1_modelWachadla(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c1_modelWachadla(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c1_modelWachadla(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c1_modelWachadla_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
