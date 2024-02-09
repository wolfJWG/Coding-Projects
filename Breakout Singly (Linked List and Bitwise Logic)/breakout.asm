; program start section
  call __global_scope_initialization
  call __function_main
  hlt

; location of global variables
  define global_malloc_start_address 0
  define global_malloc_end_address 1
  define global_malloc_first_block 2
  define global_featureMask 3

__global_scope_initialization:
  push BP
  mov BP, SP
  mov R0, 1048576
  mov [global_malloc_start_address], R0
  mov R0, 3145727
  mov [global_malloc_end_address], R0
  mov R0, -1
  mov [global_malloc_first_block], R0
  mov R0, 0
  mov [global_featureMask], R0
  mov SP, BP
  pop BP
  ret

__function_make_gray:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+2]
  shl R0, 16
  or R0, -16777216
  mov R1, [BP+2]
  shl R1, 8
  or R0, R1
  mov R1, [BP+2]
  or R0, R1
__function_make_gray_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_make_color_rgb:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+4]
  shl R0, 16
  or R0, -16777216
  mov R1, [BP+3]
  shl R1, 8
  or R0, R1
  mov R1, [BP+2]
  or R0, R1
__function_make_color_rgb_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_make_color_rgba:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+5]
  shl R0, 24
  mov R1, [BP+4]
  shl R1, 16
  or R0, R1
  mov R1, [BP+3]
  shl R1, 8
  or R0, R1
  mov R1, [BP+2]
  or R0, R1
__function_make_color_rgba_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_get_color_red:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  and R0, 255
__function_get_color_red_return:
  mov SP, BP
  pop BP
  ret

__function_get_color_green:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  shl R0, -8
  and R0, 255
__function_get_color_green_return:
  mov SP, BP
  pop BP
  ret

__function_get_color_blue:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  shl R0, -16
  and R0, 255
__function_get_color_blue_return:
  mov SP, BP
  pop BP
  ret

__function_get_color_alpha:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  shl R0, -24
  and R0, 255
__function_get_color_alpha_return:
  mov SP, BP
  pop BP
  ret

__function_select_texture:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_SelectedTexture, R0
__function_select_texture_return:
  mov SP, BP
  pop BP
  ret

__function_get_selected_texture:
  push BP
  mov BP, SP
  in R0, GPU_SelectedTexture
__function_get_selected_texture_return:
  mov SP, BP
  pop BP
  ret

__function_select_region:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_SelectedRegion, R0
__function_select_region_return:
  mov SP, BP
  pop BP
  ret

__function_get_selected_region:
  push BP
  mov BP, SP
  in R0, GPU_SelectedRegion
__function_get_selected_region_return:
  mov SP, BP
  pop BP
  ret

__function_define_region:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_RegionMinX, R0
  mov R0, [BP+3]
  out GPU_RegionMinY, R0
  mov R0, [BP+4]
  out GPU_RegionMaxX, R0
  mov R0, [BP+5]
  out GPU_RegionMaxY, R0
  mov R0, [BP+6]
  out GPU_RegionHotSpotX, R0
  mov R0, [BP+7]
  out GPU_RegionHotSpotY, R0
__function_define_region_return:
  mov SP, BP
  pop BP
  ret

__function_define_region_topleft:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_RegionMinX, R0
  out GPU_RegionHotSpotX, R0
  mov R0, [BP+3]
  out GPU_RegionMinY, R0
  out GPU_RegionHotSpotY, R0
  mov R0, [BP+4]
  out GPU_RegionMaxX, R0
  mov R0, [BP+5]
  out GPU_RegionMaxY, R0
__function_define_region_topleft_return:
  mov SP, BP
  pop BP
  ret

__function_define_region_center:
  push BP
  mov BP, SP
  isub SP, 2
  mov R0, [BP+2]
  mov R1, [BP+4]
  iadd R0, R1
  idiv R0, 2
  mov [BP-1], R0
  mov R0, [BP+3]
  mov R1, [BP+5]
  iadd R0, R1
  idiv R0, 2
  mov [BP-2], R0
  mov R0, [BP+2]
  out GPU_RegionMinX, R0
  mov R0, [BP+3]
  out GPU_RegionMinY, R0
  mov R0, [BP+4]
  out GPU_RegionMaxX, R0
  mov R0, [BP+5]
  out GPU_RegionMaxY, R0
  mov R0, [BP-1]
  out GPU_RegionHotSpotX, R0
  mov R0, [BP-2]
  out GPU_RegionHotSpotY, R0
__function_define_region_center_return:
  mov SP, BP
  pop BP
  ret

__function_define_region_matrix:
  push BP
  mov BP, SP
  isub SP, 17
  mov R0, [BP+2]
  mov [BP-1], R0
  mov R0, [BP+3]
  mov [BP-2], R0
  mov R0, [BP+4]
  mov [BP-3], R0
  mov R0, [BP+5]
  mov [BP-4], R0
  mov R0, [BP+6]
  mov [BP-5], R0
  mov R0, [BP+7]
  mov [BP-6], R0
  mov R0, [BP+8]
  mov [BP-7], R0
  mov R0, [BP-4]
  mov R1, [BP-2]
  isub R0, R1
  iadd R0, 1
  mov R1, [BP+11]
  iadd R0, R1
  mov [BP-8], R0
  mov R0, [BP-5]
  mov R1, [BP-3]
  isub R0, R1
  iadd R0, 1
  mov R1, [BP+11]
  iadd R0, R1
  mov [BP-9], R0
  mov R0, 0
  mov [BP-10], R0
__for_206_start:
  mov R0, [BP-10]
  mov R1, [BP+10]
  ilt R0, R1
  jf R0, __for_206_end
  mov R0, 0
  mov [BP-11], R0
__for_216_start:
  mov R0, [BP-11]
  mov R1, [BP+9]
  ilt R0, R1
  jf R0, __for_216_end
  mov R1, [BP-1]
  mov [SP], R1
  call __function_select_region
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, [BP-3]
  mov [SP+1], R1
  mov R1, [BP-4]
  mov [SP+2], R1
  mov R1, [BP-5]
  mov [SP+3], R1
  mov R1, [BP-6]
  mov [SP+4], R1
  mov R1, [BP-7]
  mov [SP+5], R1
  call __function_define_region
  mov R0, [BP-1]
  mov R1, R0
  iadd R1, 1
  mov [BP-1], R1
  mov R0, [BP-2]
  mov R1, [BP-8]
  iadd R0, R1
  mov [BP-2], R0
  mov R0, [BP-4]
  mov R1, [BP-8]
  iadd R0, R1
  mov [BP-4], R0
  mov R0, [BP-6]
  mov R1, [BP-8]
  iadd R0, R1
  mov [BP-6], R0
__for_216_continue:
  mov R0, [BP-11]
  iadd R0, 1
  mov [BP-11], R0
  jmp __for_216_start
__for_216_end:
  mov R0, [BP-3]
  mov R1, [BP-9]
  iadd R0, R1
  mov [BP-3], R0
  mov R0, [BP-5]
  mov R1, [BP-9]
  iadd R0, R1
  mov [BP-5], R0
  mov R0, [BP-7]
  mov R1, [BP-9]
  iadd R0, R1
  mov [BP-7], R0
  mov R0, [BP+3]
  mov [BP-2], R0
  mov R0, [BP+5]
  mov [BP-4], R0
  mov R0, [BP+7]
  mov [BP-6], R0
__for_206_continue:
  mov R0, [BP-10]
  iadd R0, 1
  mov [BP-10], R0
  jmp __for_206_start
__for_206_end:
__function_define_region_matrix_return:
  mov SP, BP
  pop BP
  ret

__function_set_region_hotspot:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_RegionHotSpotX, R0
  mov R0, [BP+3]
  out GPU_RegionHotSpotY, R0
__function_set_region_hotspot_return:
  mov SP, BP
  pop BP
  ret

__function_set_multiply_color:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_MultiplyColor, R0
__function_set_multiply_color_return:
  mov SP, BP
  pop BP
  ret

__function_set_drawing_point:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_DrawingPointX, R0
  mov R0, [BP+3]
  out GPU_DrawingPointY, R0
__function_set_drawing_point_return:
  mov SP, BP
  pop BP
  ret

__function_set_drawing_scale:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_DrawingScaleX, R0
  mov R0, [BP+3]
  out GPU_DrawingScaleY, R0
__function_set_drawing_scale_return:
  mov SP, BP
  pop BP
  ret

__function_set_drawing_angle:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_DrawingAngle, R0
__function_set_drawing_angle_return:
  mov SP, BP
  pop BP
  ret

__function_set_blending_mode:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_ActiveBlending, R0
__function_set_blending_mode_return:
  mov SP, BP
  pop BP
  ret

__function_get_multiply_color:
  push BP
  mov BP, SP
  in R0, GPU_MultiplyColor
__function_get_multiply_color_return:
  mov SP, BP
  pop BP
  ret

__function_get_drawing_point:
  push BP
  mov BP, SP
  push R1
  in R0, GPU_DrawingPointX
  mov R1, [BP+2]
  mov [R1], R0
  in R0, GPU_DrawingPointY
  mov R1, [BP+3]
  mov [R1], R0
__function_get_drawing_point_return:
  mov SP, BP
  pop BP
  ret

__function_get_drawing_scale:
  push BP
  mov BP, SP
  push R1
  in R0, GPU_DrawingScaleX
  mov R1, [BP+2]
  mov [R1], R0
  in R0, GPU_DrawingScaleY
  mov R1, [BP+3]
  mov [R1], R0
__function_get_drawing_scale_return:
  mov SP, BP
  pop BP
  ret

__function_get_drawing_angle:
  push BP
  mov BP, SP
  in R0, GPU_DrawingAngle
__function_get_drawing_angle_return:
  mov SP, BP
  pop BP
  ret

__function_get_blending_mode:
  push BP
  mov BP, SP
  in R0, GPU_ActiveBlending
__function_get_blending_mode_return:
  mov SP, BP
  pop BP
  ret

__function_clear_screen:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_ClearColor, R0
  out GPU_Command, GPUCommand_ClearScreen
__function_clear_screen_return:
  mov SP, BP
  pop BP
  ret

__function_draw_region:
  push BP
  mov BP, SP
  out GPU_Command, GPUCommand_DrawRegion
__function_draw_region_return:
  mov SP, BP
  pop BP
  ret

__function_draw_region_at:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_DrawingPointX, R0
  mov R0, [BP+3]
  out GPU_DrawingPointY, R0
  out GPU_Command, GPUCommand_DrawRegion
__function_draw_region_at_return:
  mov SP, BP
  pop BP
  ret

__function_draw_region_zoomed:
  push BP
  mov BP, SP
  out GPU_Command, GPUCommand_DrawRegionZoomed
__function_draw_region_zoomed_return:
  mov SP, BP
  pop BP
  ret

__function_draw_region_zoomed_at:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_DrawingPointX, R0
  mov R0, [BP+3]
  out GPU_DrawingPointY, R0
  out GPU_Command, GPUCommand_DrawRegionZoomed
__function_draw_region_zoomed_at_return:
  mov SP, BP
  pop BP
  ret

__function_draw_region_rotated:
  push BP
  mov BP, SP
  out GPU_Command, GPUCommand_DrawRegionRotated
__function_draw_region_rotated_return:
  mov SP, BP
  pop BP
  ret

__function_draw_region_rotated_at:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_DrawingPointX, R0
  mov R0, [BP+3]
  out GPU_DrawingPointY, R0
  out GPU_Command, GPUCommand_DrawRegionRotated
__function_draw_region_rotated_at_return:
  mov SP, BP
  pop BP
  ret

__function_draw_region_rotozoomed:
  push BP
  mov BP, SP
  out GPU_Command, GPUCommand_DrawRegionRotozoomed
__function_draw_region_rotozoomed_return:
  mov SP, BP
  pop BP
  ret

__function_draw_region_rotozoomed_at:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out GPU_DrawingPointX, R0
  mov R0, [BP+3]
  out GPU_DrawingPointY, R0
  out GPU_Command, GPUCommand_DrawRegionRotozoomed
__function_draw_region_rotozoomed_at_return:
  mov SP, BP
  pop BP
  ret

__function_print_at:
  push BP
  mov BP, SP
  isub SP, 4
  call __function_get_selected_texture
  mov [BP-1], R0
  mov R1, -1
  mov [SP], R1
  call __function_select_texture
  mov R0, [BP+2]
  mov [BP-2], R0
__while_361_start:
__while_361_continue:
  mov R0, [BP+4]
  mov R0, [R0]
  cib R0
  jf R0, __while_361_end
  mov R1, [BP+4]
  mov R1, [R1]
  mov [SP], R1
  call __function_select_region
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_draw_region_at
  mov R0, [BP+2]
  iadd R0, 10
  mov [BP+2], R0
__if_374_start:
  mov R0, [BP+4]
  mov R0, [R0]
  ieq R0, 10
  jf R0, __if_374_end
  mov R0, [BP-2]
  mov [BP+2], R0
  mov R0, [BP+3]
  iadd R0, 20
  mov [BP+3], R0
__if_374_end:
  mov R0, [BP+4]
  iadd R0, 1
  mov [BP+4], R0
  jmp __while_361_start
__while_361_end:
  mov R1, [BP-1]
  mov [SP], R1
  call __function_select_texture
__function_print_at_return:
  mov SP, BP
  pop BP
  ret

__function_print:
  push BP
  mov BP, SP
  isub SP, 5
  lea R1, [BP-1]
  mov [SP], R1
  lea R1, [BP-2]
  mov [SP+1], R1
  call __function_get_drawing_point
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  mov R1, [BP+2]
  mov [SP+2], R1
  call __function_print_at
__function_print_return:
  mov SP, BP
  pop BP
  ret

__function_select_gamepad:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out INP_SelectedGamepad, R0
__function_select_gamepad_return:
  mov SP, BP
  pop BP
  ret

__function_get_selected_gamepad:
  push BP
  mov BP, SP
  in R0, INP_SelectedGamepad
__function_get_selected_gamepad_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_is_connected:
  push BP
  mov BP, SP
  in R0, INP_GamepadConnected
__function_gamepad_is_connected_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_left:
  push BP
  mov BP, SP
  in R0, INP_GamepadLeft
__function_gamepad_left_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_right:
  push BP
  mov BP, SP
  in R0, INP_GamepadRight
__function_gamepad_right_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_up:
  push BP
  mov BP, SP
  in R0, INP_GamepadUp
__function_gamepad_up_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_down:
  push BP
  mov BP, SP
  in R0, INP_GamepadDown
__function_gamepad_down_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_direction:
  push BP
  mov BP, SP
__if_423_start:
  call __function_gamepad_left
  mov R1, R0
  igt R1, 0
  mov R0, R1
  jf R0, __if_423_else
  mov R0, -1
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
  jmp __if_423_end
__if_423_else:
__if_432_start:
  call __function_gamepad_right
  mov R1, R0
  igt R1, 0
  mov R0, R1
  jf R0, __if_432_else
  mov R0, 1
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
  jmp __if_432_end
__if_432_else:
  mov R0, 0
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
__if_432_end:
__if_423_end:
__if_444_start:
  call __function_gamepad_up
  mov R1, R0
  igt R1, 0
  mov R0, R1
  jf R0, __if_444_else
  mov R0, -1
  lea R1, [BP+3]
  mov R1, [R1]
  mov [R1], R0
  jmp __if_444_end
__if_444_else:
__if_453_start:
  call __function_gamepad_down
  mov R1, R0
  igt R1, 0
  mov R0, R1
  jf R0, __if_453_else
  mov R0, 1
  lea R1, [BP+3]
  mov R1, [R1]
  mov [R1], R0
  jmp __if_453_end
__if_453_else:
  mov R0, 0
  lea R1, [BP+3]
  mov R1, [R1]
  mov [R1], R0
__if_453_end:
__if_444_end:
__function_gamepad_direction_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_direction_normalized:
  push BP
  mov BP, SP
__if_468_start:
  call __function_gamepad_left
  mov R1, R0
  igt R1, 0
  mov R0, R1
  jf R0, __if_468_else
  mov R0, -1.000000
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
  jmp __if_468_end
__if_468_else:
__if_477_start:
  call __function_gamepad_right
  mov R1, R0
  igt R1, 0
  mov R0, R1
  jf R0, __if_477_else
  mov R0, 1.000000
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
  jmp __if_477_end
__if_477_else:
  mov R0, 0.000000
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
__if_477_end:
__if_468_end:
__if_489_start:
  call __function_gamepad_up
  mov R1, R0
  igt R1, 0
  mov R0, R1
  jf R0, __if_489_else
  mov R0, -1.000000
  lea R1, [BP+3]
  mov R1, [R1]
  mov [R1], R0
  jmp __if_489_end
__if_489_else:
__if_498_start:
  call __function_gamepad_down
  mov R1, R0
  igt R1, 0
  mov R0, R1
  jf R0, __if_498_else
  mov R0, 1.000000
  lea R1, [BP+3]
  mov R1, [R1]
  mov [R1], R0
  jmp __if_498_end
__if_498_else:
  mov R0, 0.000000
  lea R1, [BP+3]
  mov R1, [R1]
  mov [R1], R0
__if_498_end:
__if_489_end:
__if_510_start:
  mov R0, [BP+2]
  mov R0, [R0]
  cfb R0
  jf R0, __LogicalAnd_ShortCircuit_513
  mov R1, [BP+3]
  mov R1, [R1]
  cfb R1
  and R0, R1
__LogicalAnd_ShortCircuit_513:
  jf R0, __if_510_end
  mov R0, [BP+2]
  mov R0, [R0]
  fmul R0, 0.707107
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP+3]
  mov R0, [R0]
  fmul R0, 0.707107
  lea R1, [BP+3]
  mov R1, [R1]
  mov [R1], R0
__if_510_end:
__function_gamepad_direction_normalized_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_button_a:
  push BP
  mov BP, SP
  in R0, INP_GamepadButtonA
__function_gamepad_button_a_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_button_b:
  push BP
  mov BP, SP
  in R0, INP_GamepadButtonB
__function_gamepad_button_b_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_button_x:
  push BP
  mov BP, SP
  in R0, INP_GamepadButtonX
__function_gamepad_button_x_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_button_y:
  push BP
  mov BP, SP
  in R0, INP_GamepadButtonY
__function_gamepad_button_y_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_button_l:
  push BP
  mov BP, SP
  in R0, INP_GamepadButtonL
__function_gamepad_button_l_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_button_r:
  push BP
  mov BP, SP
  in R0, INP_GamepadButtonR
__function_gamepad_button_r_return:
  mov SP, BP
  pop BP
  ret

__function_gamepad_button_start:
  push BP
  mov BP, SP
  in R0, INP_GamepadButtonStart
__function_gamepad_button_start_return:
  mov SP, BP
  pop BP
  ret

__function_fmod:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+2]
  mov R1, [BP+3]
  fmod R0, R1
  pop R1
__function_fmod_return:
  mov SP, BP
  pop BP
  ret

__function_min:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+2]
  mov R1, [BP+3]
  imin R0, R1
  pop R1
__function_min_return:
  mov SP, BP
  pop BP
  ret

__function_max:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+2]
  mov R1, [BP+3]
  imax R0, R1
  pop R1
__function_max_return:
  mov SP, BP
  pop BP
  ret

__function_abs:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  iabs R0
__function_abs_return:
  mov SP, BP
  pop BP
  ret

__function_fmin:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+2]
  mov R1, [BP+3]
  fmin R0, R1
  pop R1
__function_fmin_return:
  mov SP, BP
  pop BP
  ret

__function_fmax:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+2]
  mov R1, [BP+3]
  fmax R0, R1
  pop R1
__function_fmax_return:
  mov SP, BP
  pop BP
  ret

__function_fabs:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  fabs R0
__function_fabs_return:
  mov SP, BP
  pop BP
  ret

__function_floor:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  flr R0
__function_floor_return:
  mov SP, BP
  pop BP
  ret

__function_ceil:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  ceil R0
__function_ceil_return:
  mov SP, BP
  pop BP
  ret

__function_round:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  round R0
__function_round_return:
  mov SP, BP
  pop BP
  ret

__function_sin:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  sin R0
__function_sin_return:
  mov SP, BP
  pop BP
  ret

__function_cos:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  fadd R0, 1.570796
  sin R0
__function_cos_return:
  mov SP, BP
  pop BP
  ret

__function_tan:
  push BP
  mov BP, SP
  push R1
  mov R1, [BP+2]
  mov R0, R1
  sin R0
  fadd R1, 1.570796
  sin R1
  fdiv R0, R1
  pop R1
__function_tan_return:
  mov SP, BP
  pop BP
  ret

__function_asin:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  acos R0
  fsgn R0
  fadd R0, 1.570796
__function_asin_return:
  mov SP, BP
  pop BP
  ret

__function_acos:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  acos R0
__function_acos_return:
  mov SP, BP
  pop BP
  ret

__function_atan2:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+2]
  mov R1, [BP+3]
  atan2 R0, R1
  pop R1
__function_atan2_return:
  mov SP, BP
  pop BP
  ret

__function_sqrt:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+2]
  mov R1, 0.5
  pow R0, R1
  pop R1
__function_sqrt_return:
  mov SP, BP
  pop BP
  ret

__function_pow:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+2]
  mov R1, [BP+3]
  pow R0, R1
  pop R1
__function_pow_return:
  mov SP, BP
  pop BP
  ret

__function_exp:
  push BP
  mov BP, SP
  push R1
  mov R0, 2.718282
  mov R1, [BP+2]
  pow R0, R1
  pop R1
__function_exp_return:
  mov SP, BP
  pop BP
  ret

__function_log:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  log R0
__function_log_return:
  mov SP, BP
  pop BP
  ret

__function_get_cycle_counter:
  push BP
  mov BP, SP
  in R0, TIM_CycleCounter
__function_get_cycle_counter_return:
  mov SP, BP
  pop BP
  ret

__function_get_frame_counter:
  push BP
  mov BP, SP
  in R0, TIM_FrameCounter
__function_get_frame_counter_return:
  mov SP, BP
  pop BP
  ret

__function_get_date:
  push BP
  mov BP, SP
  in R0, TIM_CurrentDate
__function_get_date_return:
  mov SP, BP
  pop BP
  ret

__function_get_time:
  push BP
  mov BP, SP
  in R0, TIM_CurrentTime
__function_get_time_return:
  mov SP, BP
  pop BP
  ret

__function_translate_date:
  push BP
  mov BP, SP
  isub SP, 15
  mov R0, [BP+2]
  shl R0, -16
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, [BP+2]
  and R0, 65535
  mov [BP-1], R0
  mov R0, 31
  mov [BP-13], R0
  mov R0, 28
  mov [BP-12], R0
  mov R0, 31
  mov [BP-11], R0
  mov R0, 30
  mov [BP-10], R0
  mov R0, 31
  mov [BP-9], R0
  mov R0, 30
  mov [BP-8], R0
  mov R0, 31
  mov [BP-7], R0
  mov R0, 31
  mov [BP-6], R0
  mov R0, 30
  mov [BP-5], R0
  mov R0, 31
  mov [BP-4], R0
  mov R0, 30
  mov [BP-3], R0
  mov R0, 31
  mov [BP-2], R0
  mov R1, [BP+3]
  mov R0, [R1]
  imod R0, 4
  ieq R0, 0
  jf R0, __LogicalAnd_ShortCircuit_688
  mov R2, [BP+3]
  mov R1, [R2]
  imod R1, 100
  ine R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_688:
  mov [BP-14], R0
__if_697_start:
  mov R0, [BP-14]
  jf R0, __if_697_end
  mov R0, 29
  mov [BP-12], R0
__if_697_end:
  mov R0, 1
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov [BP-15], R0
__for_708_start:
  mov R0, [BP-15]
  ilt R0, 11
  jf R0, __for_708_end
__if_718_start:
  mov R0, [BP-1]
  lea R1, [BP-13]
  mov R2, [BP-15]
  iadd R1, R2
  mov R1, [R1]
  ilt R0, R1
  jf R0, __if_718_end
  mov R0, [BP-1]
  iadd R0, 1
  mov R1, [BP+3]
  iadd R1, 2
  mov [R1], R0
  jmp __function_translate_date_return
__if_718_end:
  mov R0, [BP-1]
  lea R1, [BP-13]
  mov R2, [BP-15]
  iadd R1, R2
  mov R1, [R1]
  isub R0, R1
  mov [BP-1], R0
  mov R2, [BP+3]
  iadd R2, 1
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
__for_708_continue:
  mov R0, [BP-15]
  iadd R0, 1
  mov [BP-15], R0
  jmp __for_708_start
__for_708_end:
  mov R0, 12
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP-1]
  iadd R0, 1
  mov R1, [BP+3]
  iadd R1, 2
  mov [R1], R0
__function_translate_date_return:
  mov SP, BP
  pop BP
  ret

__function_translate_time:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  idiv R0, 3600
  mov R1, [BP+3]
  mov [R1], R0
  mov R0, [BP+2]
  imod R0, 3600
  idiv R0, 60
  mov R1, [BP+3]
  iadd R1, 1
  mov [R1], R0
  mov R0, [BP+2]
  imod R0, 60
  mov R1, [BP+3]
  iadd R1, 2
  mov [R1], R0
__function_translate_time_return:
  mov SP, BP
  pop BP
  ret

__function_end_frame:
  push BP
  mov BP, SP
  wait
__function_end_frame_return:
  mov SP, BP
  pop BP
  ret

__function_sleep:
  push BP
  mov BP, SP
  isub SP, 2
  call __function_get_frame_counter
  mov [BP-1], R0
  mov R0, [BP-1]
  mov R1, [BP+2]
  iadd R0, R1
  mov [BP-2], R0
__while_793_start:
__while_793_continue:
  call __function_get_frame_counter
  mov R1, R0
  mov R2, [BP-2]
  ilt R1, R2
  mov R0, R1
  jf R0, __while_793_end
  call __function_end_frame
  jmp __while_793_start
__while_793_end:
__function_sleep_return:
  mov SP, BP
  pop BP
  ret

__function_memset:
  push BP
  mov BP, SP
  mov CR, [BP+4]
  mov DR, [BP+2]
  mov SR, [BP+3]
  sets
__function_memset_return:
  mov SP, BP
  pop BP
  ret

__function_memcpy:
  push BP
  mov BP, SP
  mov CR, [BP+4]
  mov DR, [BP+2]
  mov SR, [BP+3]
  movs
__function_memcpy_return:
  mov SP, BP
  pop BP
  ret

__function_memcmp:
  push BP
  mov BP, SP
  mov CR, [BP+4]
  mov DR, [BP+2]
  mov SR, [BP+3]
  cmps R0
__function_memcmp_return:
  mov SP, BP
  pop BP
  ret

__function_merge_free_malloc_blocks:
  push BP
  mov BP, SP
  isub SP, 2
  mov R1, [BP+2]
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-2], R0
__if_864_start:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __LogicalAnd_ShortCircuit_866
  mov R2, [BP-2]
  iadd R2, 3
  mov R1, [R2]
  and R0, R1
__LogicalAnd_ShortCircuit_866:
  jf R0, __if_864_end
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
__if_875_start:
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_875_end
  mov R0, [BP+2]
  mov R2, [BP-2]
  iadd R2, 1
  mov R1, [R2]
  mov [R1], R0
__if_875_end:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov R2, [BP-2]
  iadd R2, 2
  mov R1, [R2]
  iadd R1, 4
  iadd R0, R1
  mov R1, [BP+2]
  iadd R1, 2
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-2], R0
__if_864_end:
__if_894_start:
  mov R0, [BP-1]
  ine R0, -1
  jf R0, __LogicalAnd_ShortCircuit_896
  mov R2, [BP-1]
  iadd R2, 3
  mov R1, [R2]
  and R0, R1
__LogicalAnd_ShortCircuit_896:
  jf R0, __if_894_end
  mov R0, [BP-2]
  mov R1, [BP-1]
  iadd R1, 1
  mov [R1], R0
__if_904_start:
  mov R0, [BP-2]
  ine R0, -1
  jf R0, __if_904_end
  mov R0, [BP-1]
  mov R1, [BP-2]
  mov [R1], R0
__if_904_end:
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  iadd R1, 4
  iadd R0, R1
  mov R1, [BP-1]
  iadd R1, 2
  mov [R1], R0
__if_894_end:
__function_merge_free_malloc_blocks_return:
  mov SP, BP
  pop BP
  ret

__function_reduce_malloc_block:
  push BP
  mov BP, SP
  isub SP, 3
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP+3]
  isub R0, R1
  mov [BP-1], R0
__if_926_start:
  mov R0, [BP-1]
  ile R0, 4
  jf R0, __if_926_end
  jmp __function_reduce_malloc_block_return
__if_926_end:
  mov R0, [BP+2]
  iadd R0, 4
  mov R1, [BP+3]
  iadd R0, R1
  mov [BP-2], R0
  mov R0, [BP+2]
  mov R1, [BP-2]
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-2]
  iadd R1, 1
  mov [R1], R0
  mov R0, 1
  mov R1, [BP-2]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP-1]
  isub R0, 4
  mov R1, [BP-2]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP+3]
  mov R1, [BP+2]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-2]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
__if_969_start:
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_969_end
  mov R0, [BP-2]
  mov R2, [BP-2]
  iadd R2, 1
  mov R1, [R2]
  mov [R1], R0
__if_969_end:
  mov R1, [BP-2]
  mov [SP], R1
  call __function_merge_free_malloc_blocks
__function_reduce_malloc_block_return:
  mov SP, BP
  pop BP
  ret

__function_expand_malloc_block:
  push BP
  mov BP, SP
  isub SP, 3
  push R1
  push R2
  isub SP, 2
  mov R0, [BP+3]
  mov R2, [BP+2]
  iadd R2, 2
  mov R1, [R2]
  isub R0, R1
  mov [BP-1], R0
__if_988_start:
  mov R0, [BP-1]
  ile R0, 0
  jf R0, __if_988_end
  mov R0, 1
  jmp __function_expand_malloc_block_return
__if_988_end:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-2], R0
__if_998_start:
  mov R0, [BP-2]
  ine R0, -1
  bnot R0
  jt R0, __LogicalOr_ShortCircuit_1001
  mov R2, [BP-2]
  iadd R2, 3
  mov R1, [R2]
  bnot R1
  or R0, R1
__LogicalOr_ShortCircuit_1001:
  jf R0, __if_998_end
  mov R0, 0
  jmp __function_expand_malloc_block_return
__if_998_end:
  mov R1, [BP-2]
  iadd R1, 2
  mov R0, [R1]
  iadd R0, 4
  mov [BP-3], R0
__if_1013_start:
  mov R0, [BP-3]
  mov R1, [BP-1]
  ilt R0, R1
  jf R0, __if_1013_end
  mov R0, 0
  jmp __function_expand_malloc_block_return
__if_1013_end:
  mov R1, [BP+2]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R0, R1
  mov R1, [BP+2]
  iadd R1, 2
  mov [R1], R0
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
__if_1028_start:
  mov R1, [BP-2]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_1028_end
  mov R0, [BP+2]
  mov R2, [BP-2]
  iadd R2, 1
  mov R1, [R2]
  mov [R1], R0
__if_1028_end:
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_reduce_malloc_block
  mov R0, 1
__function_expand_malloc_block_return:
  iadd SP, 2
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_malloc:
  push BP
  mov BP, SP
  isub SP, 3
  push R1
  push R2
__if_1043_start:
  mov R0, [global_malloc_first_block]
  ine R0, -1
  bnot R0
  jf R0, __if_1043_end
  mov R0, [global_malloc_start_address]
  mov [global_malloc_first_block], R0
  mov R0, [global_malloc_end_address]
  mov R1, [global_malloc_start_address]
  isub R0, R1
  iadd R0, 1
  mov R1, [global_malloc_first_block]
  iadd R1, 2
  mov [R1], R0
  mov R1, [global_malloc_first_block]
  iadd R1, 2
  mov R0, [R1]
  isub R0, 4
  mov R1, [global_malloc_first_block]
  iadd R1, 2
  mov [R1], R0
  mov R0, -1
  mov R1, [global_malloc_first_block]
  mov [R1], R0
  mov R0, -1
  mov R1, [global_malloc_first_block]
  iadd R1, 1
  mov [R1], R0
  mov R0, 1
  mov R1, [global_malloc_first_block]
  iadd R1, 3
  mov [R1], R0
__if_1043_end:
__if_1078_start:
  mov R0, [BP+2]
  ile R0, 0
  jf R0, __if_1078_end
  mov R0, -1
  jmp __function_malloc_return
__if_1078_end:
  mov R0, [global_malloc_first_block]
  mov [BP-1], R0
__while_1087_start:
__while_1087_continue:
  mov R0, [BP-1]
  ine R0, -1
  jf R0, __while_1087_end
__if_1090_start:
  mov R1, [BP-1]
  iadd R1, 3
  mov R0, [R1]
  jf R0, __LogicalAnd_ShortCircuit_1093
  mov R2, [BP-1]
  iadd R2, 2
  mov R1, [R2]
  mov R2, [BP+2]
  ige R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_1093:
  jf R0, __if_1090_end
  jmp __while_1087_end
__if_1090_end:
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  mov [BP-1], R0
  jmp __while_1087_start
__while_1087_end:
__if_1103_start:
  mov R0, [BP-1]
  ine R0, -1
  bnot R0
  jf R0, __if_1103_end
  mov R0, -1
  jmp __function_malloc_return
__if_1103_end:
  mov R0, [BP+2]
  iadd R0, 4
  mov [BP-2], R0
__if_1113_start:
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-2]
  igt R0, R1
  jf R0, __if_1113_else
  mov R0, [BP-1]
  iadd R0, 4
  mov R2, [BP-1]
  iadd R2, 2
  mov R1, [R2]
  iadd R0, R1
  mov R1, [BP-2]
  isub R0, R1
  mov [BP-3], R0
  mov R0, [BP+2]
  mov R1, [BP-3]
  iadd R1, 2
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-3]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP-1]
  mov R1, [BP-3]
  mov [R1], R0
  mov R1, [BP-1]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-3]
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP-2]
  isub R0, R1
  mov R1, [BP-1]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-3]
  mov R1, [BP-1]
  iadd R1, 1
  mov [R1], R0
__if_1158_start:
  mov R1, [BP-3]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_1158_end
  mov R0, [BP-3]
  mov R2, [BP-3]
  iadd R2, 1
  mov R1, [R2]
  mov [R1], R0
__if_1158_end:
  mov R0, [BP-3]
  iadd R0, 4
  jmp __function_malloc_return
  jmp __if_1113_end
__if_1113_else:
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 3
  mov [R1], R0
  mov R0, [BP-1]
  iadd R0, 4
  jmp __function_malloc_return
__if_1113_end:
__function_malloc_return:
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_free:
  push BP
  mov BP, SP
  isub SP, 2
__if_1183_start:
  mov R0, [BP+2]
  ine R0, -1
  bnot R0
  jf R0, __if_1183_end
  jmp __function_free_return
__if_1183_end:
  mov R0, [BP+2]
  isub R0, 4
  mov [BP-1], R0
  mov R0, 1
  mov R1, [BP-1]
  iadd R1, 3
  mov [R1], R0
  mov R1, [BP-1]
  mov [SP], R1
  call __function_merge_free_malloc_blocks
__function_free_return:
  mov SP, BP
  pop BP
  ret

__function_calloc:
  push BP
  mov BP, SP
  isub SP, 2
  push R1
  isub SP, 3
  mov R0, [BP+2]
  mov R1, [BP+3]
  imul R0, R1
  mov [BP-1], R0
  mov R1, [BP-1]
  mov [SP], R1
  call __function_malloc
  mov [BP-2], R0
__if_1211_start:
  mov R0, [BP-2]
  ine R0, -1
  bnot R0
  jf R0, __if_1211_end
  mov R0, -1
  jmp __function_calloc_return
__if_1211_end:
  mov R1, [BP-2]
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, [BP-1]
  mov [SP+2], R1
  call __function_memset
  mov R0, [BP-2]
__function_calloc_return:
  iadd SP, 3
  pop R1
  mov SP, BP
  pop BP
  ret

__function_realloc:
  push BP
  mov BP, SP
  isub SP, 3
  push R1
  isub SP, 3
__if_1225_start:
  mov R0, [BP+2]
  ine R0, -1
  bnot R0
  jf R0, __if_1225_end
  mov R1, [BP+3]
  mov [SP], R1
  call __function_malloc
  jmp __function_realloc_return
__if_1225_end:
__if_1231_start:
  mov R0, [BP+3]
  ile R0, 0
  jf R0, __if_1231_end
  mov R1, [BP+2]
  mov [SP], R1
  call __function_free
  mov R0, -1
  jmp __function_realloc_return
__if_1231_end:
  mov R0, [BP+2]
  isub R0, 4
  mov [BP-1], R0
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov [BP-2], R0
__if_1250_start:
  mov R0, [BP+3]
  mov R1, [BP-2]
  ieq R0, R1
  jf R0, __if_1250_end
  mov R0, [BP+2]
  jmp __function_realloc_return
__if_1250_end:
__if_1256_start:
  mov R0, [BP+3]
  mov R1, [BP-2]
  ilt R0, R1
  jf R0, __if_1256_else
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_reduce_malloc_block
  mov R0, [BP+2]
  jmp __function_realloc_return
  jmp __if_1256_end
__if_1256_else:
__if_1267_start:
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  call __function_expand_malloc_block
  jf R0, __if_1267_else
  mov R0, [BP+2]
  jmp __function_realloc_return
  jmp __if_1267_end
__if_1267_else:
  mov R1, [BP+3]
  mov [SP], R1
  call __function_malloc
  mov [BP-3], R0
__if_1278_start:
  mov R0, [BP-3]
  ine R0, -1
  bnot R0
  jf R0, __if_1278_end
  mov R0, -1
  jmp __function_realloc_return
__if_1278_end:
  mov R1, [BP-3]
  mov [SP], R1
  mov R1, [BP+2]
  mov [SP+1], R1
  mov R1, [BP-2]
  mov [SP+2], R1
  call __function_memcpy
  mov R1, [BP+2]
  mov [SP], R1
  call __function_free
  mov R0, [BP-3]
  jmp __function_realloc_return
__if_1267_end:
__if_1256_end:
__function_realloc_return:
  iadd SP, 3
  pop R1
  mov SP, BP
  pop BP
  ret

__function_rand:
  push BP
  mov BP, SP
  in R0, RNG_CurrentValue
__function_rand_return:
  mov SP, BP
  pop BP
  ret

__function_srand:
  push BP
  mov BP, SP
  mov R0, [BP+2]
  out RNG_CurrentValue, R0
__function_srand_return:
  mov SP, BP
  pop BP
  ret

__function_exit:
  push BP
  mov BP, SP
  hlt
__function_exit_return:
  mov SP, BP
  pop BP
  ret

__function_OnFeature:
  push BP
  mov BP, SP
  mov R0, [global_featureMask]
  mov R1, 1
  mov R2, [BP+2]
  shl R1, R2
  or R0, R1
  mov [global_featureMask], R0
__function_OnFeature_return:
  mov SP, BP
  pop BP
  ret

__function_main:
  push BP
  mov BP, SP
  isub SP, 38
  mov R1, 0
  mov [SP], R1
  call __function_select_texture
  mov R1, 0
  mov [SP], R1
  call __function_select_region
  mov R1, 65
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, 81
  mov [SP+2], R1
  mov R1, 16
  mov [SP+3], R1
  mov R1, 73
  mov [SP+4], R1
  mov R1, 8
  mov [SP+5], R1
  call __function_define_region
  mov R1, 1
  mov [SP], R1
  call __function_select_region
  mov R1, 0
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, 64
  mov [SP+2], R1
  mov R1, 16
  mov [SP+3], R1
  mov R1, 32
  mov [SP+4], R1
  mov R1, 8
  mov [SP+5], R1
  call __function_define_region
  mov R1, 2
  mov [SP], R1
  call __function_select_region
  mov R1, 0
  mov [SP], R1
  mov R1, 17
  mov [SP+1], R1
  mov R1, 64
  mov [SP+2], R1
  mov R1, 33
  mov [SP+3], R1
  mov R1, 32
  mov [SP+4], R1
  mov R1, 26
  mov [SP+5], R1
  call __function_define_region
  mov R1, 3
  mov [SP], R1
  call __function_select_region
  mov R1, 65
  mov [SP], R1
  mov R1, 17
  mov [SP+1], R1
  mov R1, 81
  mov [SP+2], R1
  mov R1, 32
  mov [SP+3], R1
  mov R1, 73
  mov [SP+4], R1
  mov R1, 25
  mov [SP+5], R1
  call __function_define_region
  mov R1, 5
  mov [SP], R1
  call __function_select_region
  mov R1, 0
  mov [SP], R1
  mov R1, 35
  mov [SP+1], R1
  mov R1, 128
  mov [SP+2], R1
  mov R1, 67
  mov [SP+3], R1
  mov R1, 64
  mov [SP+4], R1
  mov R1, 51
  mov [SP+5], R1
  call __function_define_region
  mov R1, 4
  mov [SP], R1
  call __function_select_region
  mov R1, 82
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, 114
  mov [SP+2], R1
  mov R1, 32
  mov [SP+3], R1
  mov R1, 98
  mov [SP+4], R1
  mov R1, 16
  mov [SP+5], R1
  call __function_define_region
  mov R1, 0
  mov [SP], R1
  call __function_select_gamepad
  mov R0, 1
  mov [BP-5], R0
  mov R0, 64
  mov [BP-2], R0
  mov R0, 28
  mov [BP-1], R0
  mov R0, 320
  mov [BP-4], R0
  mov R0, 340
  mov [BP-3], R0
  mov R0, 1
  mov [BP-10], R0
  mov R0, 8
  mov [BP-7], R0
  mov R0, 8
  mov [BP-6], R0
  mov R0, 320
  mov [BP-9], R0
  mov R0, 180
  mov [BP-8], R0
  mov R0, 1
  mov [BP-15], R0
  mov R0, 16
  mov [BP-12], R0
  mov R0, 16
  mov [BP-11], R0
  mov R0, 320
  mov [BP-14], R0
  mov R0, 0
  mov [BP-13], R0
  mov R0, 30
  mov [BP-16], R0
  mov R0, -1
  mov [BP-17], R0
  mov R0, 0
  mov [BP-27], R0
__for_1469_start:
  mov R0, [BP-27]
  mov R1, [BP-16]
  ilt R0, R1
  jf R0, __for_1469_end
  mov R2, 6
  mov [SP], R2
  call __function_malloc
  mov R1, R0
  mov R0, R1
  mov [BP-28], R0
  mov R0, 1
  mov R1, [BP-28]
  mov [R1], R0
  mov R0, 64
  mov R1, [BP-28]
  iadd R1, 3
  mov [R1], R0
  mov R0, 32
  mov R1, [BP-28]
  iadd R1, 4
  mov [R1], R0
__if_1496_start:
  mov R0, [BP-27]
  ieq R0, 0
  jf R0, __if_1496_else
  mov R0, 32
  mov R1, [BP-28]
  iadd R1, 1
  mov [R1], R0
  mov R0, 8
  mov R1, [BP-28]
  iadd R1, 2
  mov [R1], R0
  jmp __if_1496_end
__if_1496_else:
__if_1509_start:
  mov R0, [BP-27]
  ige R0, 1
  jf R0, __LogicalAnd_ShortCircuit_1514
  mov R1, [BP-27]
  ilt R1, 10
  and R0, R1
__LogicalAnd_ShortCircuit_1514:
  jf R0, __if_1509_else
  mov R0, [BP-27]
  mov R2, [BP-28]
  iadd R2, 3
  mov R1, [R2]
  imul R0, R1
  iadd R0, 32
  mov R1, [BP-28]
  iadd R1, 1
  mov [R1], R0
  mov R0, 8
  mov R1, [BP-28]
  iadd R1, 2
  mov [R1], R0
  jmp __if_1509_end
__if_1509_else:
__if_1532_start:
  mov R0, [BP-27]
  ige R0, 10
  jf R0, __LogicalAnd_ShortCircuit_1537
  mov R1, [BP-27]
  ile R1, 19
  and R0, R1
__LogicalAnd_ShortCircuit_1537:
  jf R0, __if_1532_else
  mov R0, [BP-27]
  isub R0, 10
  mov R2, [BP-28]
  iadd R2, 3
  mov R1, [R2]
  imul R0, R1
  iadd R0, 32
  mov R1, [BP-28]
  iadd R1, 1
  mov [R1], R0
  mov R0, 28
  mov R1, [BP-28]
  iadd R1, 2
  mov [R1], R0
  jmp __if_1532_end
__if_1532_else:
  mov R0, [BP-27]
  isub R0, 20
  mov R2, [BP-28]
  iadd R2, 3
  mov R1, [R2]
  imul R0, R1
  iadd R0, 32
  mov R1, [BP-28]
  iadd R1, 1
  mov [R1], R0
  mov R0, 48
  mov R1, [BP-28]
  iadd R1, 2
  mov [R1], R0
__if_1532_end:
__if_1509_end:
__if_1496_end:
  mov R0, [BP-17]
  mov R1, [BP-28]
  iadd R1, 5
  mov [R1], R0
  mov R0, [BP-28]
  mov [BP-17], R0
__for_1469_continue:
  mov R0, [BP-27]
  mov R1, R0
  iadd R1, 1
  mov [BP-27], R1
  jmp __for_1469_start
__for_1469_end:
  mov R0, 1
  mov [BP-18], R0
  mov R0, 1
  mov [BP-19], R0
  mov R0, 2
  mov [BP-20], R0
  mov R0, 3
  mov [BP-21], R0
  mov R0, 5
  mov [BP-22], R0
  mov R0, 0
  mov [BP-23], R0
  call __function_get_time
  mov R1, R0
  mov [BP-32], R1
  mov R1, [BP-32]
  mov [SP], R1
  call __function_srand
  mov R0, 0
  mov [BP-24], R0
  mov R0, 0
  mov [BP-25], R0
  mov R0, -1
  mov [BP-26], R0
__while_1613_start:
__while_1613_continue:
  mov R0, 1
  jf R0, __while_1613_end
  mov R2, 128
  mov [SP], R2
  mov R2, 100
  mov [SP+1], R2
  mov R2, 128
  mov [SP+2], R2
  call __function_make_color_rgb
  mov R1, R0
  mov [BP-32], R1
  mov R1, [BP-32]
  mov [SP], R1
  call __function_clear_screen
  lea R1, [BP-27]
  mov [SP], R1
  lea R1, [BP-28]
  mov [SP+1], R1
  call __function_gamepad_direction
__if_1629_start:
  mov R0, [BP-5]
  jf R0, __if_1629_end
  mov R0, [BP-4]
  mov R1, [BP-27]
  imul R1, 8
  iadd R0, R1
  mov [BP-4], R0
__if_1639_start:
  mov R0, [BP-9]
  mov R1, [BP-7]
  idiv R1, 2
  isub R0, R1
  mov R1, [BP-4]
  mov R2, [BP-2]
  idiv R2, 2
  iadd R1, R2
  ile R0, R1
  jf R0, __LogicalAnd_ShortCircuit_1657
  mov R1, [BP-9]
  mov R2, [BP-7]
  idiv R2, 2
  iadd R1, R2
  mov R2, [BP-4]
  mov R3, [BP-2]
  idiv R3, 2
  isub R2, R3
  ige R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_1657:
  jf R0, __LogicalAnd_ShortCircuit_1673
  mov R1, [BP-8]
  mov R2, [BP-6]
  idiv R2, 2
  isub R1, R2
  mov R2, [BP-3]
  mov R3, [BP-1]
  idiv R3, 2
  iadd R2, R3
  ile R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_1673:
  jf R0, __LogicalAnd_ShortCircuit_1689
  mov R1, [BP-8]
  mov R2, [BP-6]
  idiv R2, 2
  iadd R1, R2
  mov R2, [BP-3]
  mov R3, [BP-1]
  idiv R3, 2
  isub R2, R3
  ige R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_1689:
  jf R0, __if_1639_end
  mov R0, [BP-19]
  imul R0, -1
  mov [BP-19], R0
__if_1639_end:
  mov R0, [BP-17]
  mov [BP-30], R0
__while_1712_start:
__while_1712_continue:
  mov R0, [BP-30]
  ine R0, -1
  jf R0, __while_1712_end
__if_1717_start:
  mov R1, [BP-30]
  mov R0, [R1]
  jf R0, __if_1717_end
__if_1721_start:
  mov R0, [BP-9]
  mov R1, [BP-7]
  idiv R1, 2
  isub R0, R1
  mov R2, [BP-30]
  iadd R2, 1
  mov R1, [R2]
  mov R3, [BP-30]
  iadd R3, 3
  mov R2, [R3]
  idiv R2, 2
  iadd R1, R2
  ile R0, R1
  jf R0, __LogicalAnd_ShortCircuit_1739
  mov R1, [BP-9]
  mov R2, [BP-7]
  idiv R2, 2
  iadd R1, R2
  mov R3, [BP-30]
  iadd R3, 1
  mov R2, [R3]
  mov R4, [BP-30]
  iadd R4, 3
  mov R3, [R4]
  idiv R3, 2
  isub R2, R3
  ige R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_1739:
  jf R0, __LogicalAnd_ShortCircuit_1755
  mov R1, [BP-8]
  mov R2, [BP-6]
  idiv R2, 2
  isub R1, R2
  mov R3, [BP-30]
  iadd R3, 2
  mov R2, [R3]
  mov R4, [BP-30]
  iadd R4, 4
  mov R3, [R4]
  idiv R3, 2
  iadd R2, R3
  ile R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_1755:
  jf R0, __LogicalAnd_ShortCircuit_1771
  mov R1, [BP-8]
  mov R2, [BP-6]
  idiv R2, 2
  iadd R1, R2
  mov R3, [BP-30]
  iadd R3, 2
  mov R2, [R3]
  mov R4, [BP-30]
  iadd R4, 4
  mov R3, [R4]
  idiv R3, 2
  isub R2, R3
  ige R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_1771:
  jf R0, __if_1721_end
  mov R0, 0
  mov R1, [BP-30]
  mov [R1], R0
  mov R0, [BP-19]
  imul R0, -1
  mov [BP-19], R0
  mov R0, [BP-23]
  mov R1, R0
  iadd R1, 1
  mov [BP-23], R1
__if_1796_start:
  mov R0, [BP-23]
  ige R0, 2
  jf R0, __if_1796_end
  mov R0, 1
  mov [BP-15], R0
  call __function_rand
  mov R1, R0
  imod R1, 640
  mov [BP-14], R1
  mov R0, R1
  mov R0, 0
  mov [BP-13], R0
  mov R0, 0
  mov [BP-23], R0
__if_1796_end:
__if_1721_end:
__if_1717_end:
  mov R1, [BP-30]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-30], R0
  jmp __while_1712_start
__while_1712_end:
__if_1629_end:
  mov R2, [BP-4]
  mov [SP], R2
  mov R2, [BP-2]
  idiv R2, 2
  mov [SP+1], R2
  call __function_max
  mov R1, R0
  mov [BP-4], R1
  mov R0, R1
  mov R2, [BP-4]
  mov [SP], R2
  mov R2, [BP-2]
  idiv R2, 2
  isgn R2
  iadd R2, 640
  mov [SP+1], R2
  call __function_min
  mov R1, R0
  mov [BP-4], R1
  mov R0, R1
  mov R0, [BP-9]
  mov R1, [BP-20]
  mov R2, [BP-18]
  imul R1, R2
  iadd R0, R1
  mov [BP-9], R0
  mov R0, [BP-8]
  mov R1, [BP-20]
  mov R2, [BP-19]
  imul R1, R2
  iadd R0, R1
  mov [BP-8], R0
  mov R2, [BP-9]
  mov [SP], R2
  mov R2, [BP-7]
  idiv R2, 2
  mov [SP+1], R2
  call __function_max
  mov R1, R0
  mov [BP-9], R1
  mov R0, R1
  mov R2, [BP-8]
  mov [SP], R2
  mov R2, [BP-6]
  idiv R2, 2
  mov [SP+1], R2
  call __function_max
  mov R1, R0
  mov [BP-8], R1
  mov R0, R1
  mov R2, [BP-9]
  mov [SP], R2
  mov R2, [BP-7]
  idiv R2, 2
  isgn R2
  iadd R2, 640
  mov [SP+1], R2
  call __function_min
  mov R1, R0
  mov [BP-9], R1
  mov R0, R1
  mov R2, [BP-8]
  mov [SP], R2
  mov R2, [BP-6]
  idiv R2, 2
  isgn R2
  iadd R2, 360
  mov [SP+1], R2
  call __function_min
  mov R1, R0
  mov [BP-8], R1
  mov R0, R1
__if_1901_start:
  mov R0, [BP-8]
  mov R1, [BP-6]
  isgn R1
  iadd R1, 360
  ige R0, R1
  jf R0, __if_1901_end
  mov R0, 320
  mov [BP-9], R0
  mov R0, 180
  mov [BP-8], R0
  mov R0, 1
  mov [BP-18], R0
  mov R0, 1
  mov [BP-19], R0
__if_1901_end:
__if_1928_start:
  mov R0, [BP-9]
  mov R1, [BP-7]
  ile R0, R1
  jt R0, __LogicalOr_ShortCircuit_1936
  mov R1, [BP-9]
  mov R2, [BP-7]
  isgn R2
  iadd R2, 640
  ige R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_1936:
  jf R0, __if_1928_end
  mov R0, [BP-18]
  imul R0, -1
  mov [BP-18], R0
__if_1928_end:
__if_1947_start:
  mov R0, [BP-8]
  mov R1, [BP-6]
  ile R0, R1
  jt R0, __LogicalOr_ShortCircuit_1955
  mov R1, [BP-8]
  mov R2, [BP-6]
  isgn R2
  iadd R2, 360
  ige R1, R2
  or R0, R1
__LogicalOr_ShortCircuit_1955:
  jf R0, __if_1947_end
  mov R0, [BP-19]
  imul R0, -1
  mov [BP-19], R0
__if_1947_end:
__if_1966_start:
  mov R0, [BP-5]
  jf R0, __LogicalAnd_ShortCircuit_1969
  mov R1, [BP-15]
  and R0, R1
__LogicalAnd_ShortCircuit_1969:
  jf R0, __LogicalAnd_ShortCircuit_1974
  mov R1, [BP-14]
  mov R2, [BP-12]
  idiv R2, 2
  isub R1, R2
  mov R2, [BP-4]
  mov R3, [BP-2]
  idiv R3, 2
  iadd R2, R3
  ile R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_1974:
  jf R0, __LogicalAnd_ShortCircuit_1990
  mov R1, [BP-14]
  mov R2, [BP-12]
  idiv R2, 2
  iadd R1, R2
  mov R2, [BP-4]
  mov R3, [BP-2]
  idiv R3, 2
  isub R2, R3
  ige R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_1990:
  jf R0, __LogicalAnd_ShortCircuit_2006
  mov R1, [BP-13]
  mov R2, [BP-11]
  idiv R2, 2
  iadd R1, R2
  mov R2, [BP-3]
  mov R3, [BP-1]
  idiv R3, 2
  isub R2, R3
  ige R1, R2
  and R0, R1
__LogicalAnd_ShortCircuit_2006:
  jf R0, __if_1966_end
  mov R0, 0
  mov [BP-15], R0
__if_2025_start:
  mov R0, [global_featureMask]
  ine R0, 0
  jf R0, __if_2025_end
  mov R0, 0
  mov [global_featureMask], R0
__if_2025_end:
__do_2035_start:
  call __function_rand
  mov R1, R0
  imod R1, 8
  mov [BP-30], R1
  mov R0, R1
__do_2035_continue:
  mov R0, [BP-30]
  mov R1, [BP-26]
  ieq R0, R1
  jt R0, __do_2035_start
__do_2035_end:
  mov R0, [BP-30]
  mov [BP-26], R0
  mov R1, [BP-30]
  mov [SP], R1
  call __function_OnFeature
__if_1966_end:
__if_2050_start:
  mov R0, [global_featureMask]
  and R0, 1
  cib R0
  jf R0, __if_2050_end
  mov R0, [BP-4]
  mov R1, [BP-27]
  imul R1, 12
  iadd R0, R1
  mov [BP-4], R0
  mov R1, 10
  mov [SP], R1
  mov R1, 335
  mov [SP+1], R1
  mov R1, __literal_string_2067
  mov [SP+2], R1
  call __function_print_at
__if_2050_end:
__if_2068_start:
  mov R0, [global_featureMask]
  and R0, 2
  cib R0
  jf R0, __if_2068_end
  mov R0, [BP-9]
  mov R1, [BP-21]
  mov R2, [BP-18]
  imul R1, R2
  iadd R0, R1
  mov [BP-9], R0
  mov R0, [BP-8]
  mov R1, [BP-21]
  mov R2, [BP-19]
  imul R1, R2
  iadd R0, R1
  mov [BP-8], R0
  mov R1, 10
  mov [SP], R1
  mov R1, 335
  mov [SP+1], R1
  mov R1, __literal_string_2091
  mov [SP+2], R1
  call __function_print_at
__if_2068_end:
__if_2092_start:
  mov R0, [global_featureMask]
  and R0, 4
  cib R0
  jf R0, __if_2092_end
  mov R0, [BP-9]
  mov R1, [BP-22]
  mov R2, [BP-18]
  imul R1, R2
  iadd R0, R1
  mov [BP-9], R0
  mov R0, [BP-8]
  mov R1, [BP-22]
  mov R2, [BP-19]
  imul R1, R2
  iadd R0, R1
  mov [BP-8], R0
  mov R1, 10
  mov [SP], R1
  mov R1, 335
  mov [SP+1], R1
  mov R1, __literal_string_2115
  mov [SP+2], R1
  call __function_print_at
__if_2092_end:
__if_2116_start:
  mov R0, [global_featureMask]
  and R0, 8
  cib R0
  jf R0, __if_2116_end
  mov R0, [BP-4]
  mov R1, [BP-27]
  imul R1, 16
  iadd R0, R1
  mov [BP-4], R0
  mov R1, 10
  mov [SP], R1
  mov R1, 335
  mov [SP+1], R1
  mov R1, __literal_string_2133
  mov [SP+2], R1
  call __function_print_at
__if_2116_end:
__if_2134_start:
  mov R0, [global_featureMask]
  and R0, 16
  cib R0
  jf R0, __if_2134_else
  mov R0, 128
  mov [BP-2], R0
  mov R0, 35
  mov [BP-1], R0
  mov R1, 5
  mov [SP], R1
  call __function_select_region
  mov R1, [BP-4]
  mov [SP], R1
  mov R1, 340
  mov [SP+1], R1
  call __function_draw_region_at
  mov R1, 10
  mov [SP], R1
  mov R1, 335
  mov [SP+1], R1
  mov R1, __literal_string_2159
  mov [SP+2], R1
  call __function_print_at
  jmp __if_2134_end
__if_2134_else:
  mov R0, 64
  mov [BP-2], R0
  mov R0, 28
  mov [BP-1], R0
  mov R1, 2
  mov [SP], R1
  call __function_select_region
  mov R1, [BP-4]
  mov [SP], R1
  mov R1, 340
  mov [SP+1], R1
  call __function_draw_region_at
__if_2134_end:
__if_2175_start:
  mov R0, [global_featureMask]
  and R0, 32
  cib R0
  jf R0, __if_2175_else
  mov R0, 20
  mov [BP-7], R0
  mov R0, 20
  mov [BP-6], R0
  mov R1, 4
  mov [SP], R1
  call __function_select_region
  mov R1, [BP-9]
  mov [SP], R1
  mov R1, [BP-8]
  mov [SP+1], R1
  call __function_draw_region_at
  mov R1, 10
  mov [SP], R1
  mov R1, 335
  mov [SP+1], R1
  mov R1, __literal_string_2201
  mov [SP+2], R1
  call __function_print_at
  jmp __if_2175_end
__if_2175_else:
  mov R0, 16
  mov [BP-7], R0
  mov R0, 16
  mov [BP-6], R0
  mov R1, 0
  mov [SP], R1
  call __function_select_region
  mov R1, [BP-9]
  mov [SP], R1
  mov R1, [BP-8]
  mov [SP+1], R1
  call __function_draw_region_at
__if_2175_end:
__if_2218_start:
  mov R0, [global_featureMask]
  and R0, 64
  cib R0
  jf R0, __if_2218_end
__if_2226_start:
  mov R0, [BP-24]
  bnot R0
  jf R0, __if_2226_end
  mov R0, [BP-17]
  mov [BP-30], R0
__while_2233_start:
__while_2233_continue:
  mov R0, [BP-30]
  ine R0, -1
  jf R0, __while_2233_end
  mov R0, 1
  mov R1, [BP-30]
  mov [R1], R0
  mov R1, [BP-30]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-30], R0
  jmp __while_2233_start
__while_2233_end:
  mov R1, 10
  mov [SP], R1
  mov R1, 335
  mov [SP+1], R1
  mov R1, __literal_string_2249
  mov [SP+2], R1
  call __function_print_at
  mov R0, 1
  mov [BP-24], R0
__if_2226_end:
__if_2218_end:
__if_2253_start:
  mov R0, [global_featureMask]
  and R0, 128
  cib R0
  jf R0, __if_2253_else
__if_2261_start:
  mov R0, [BP-25]
  bnot R0
  jf R0, __if_2261_end
  mov R0, [BP-17]
  mov [BP-30], R0
  mov R0, 0
  mov [BP-31], R0
__while_2271_start:
__while_2271_continue:
  mov R0, [BP-30]
  ine R0, -1
  jf R0, __while_2271_end
__if_2276_start:
  mov R0, [BP-31]
  imod R0, 2
  ieq R0, 0
  jf R0, __if_2276_end
  mov R0, 0
  mov R1, [BP-30]
  mov [R1], R0
__if_2276_end:
  mov R1, [BP-30]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-30], R0
  mov R0, [BP-31]
  mov R1, R0
  iadd R1, 1
  mov [BP-31], R1
  jmp __while_2271_start
__while_2271_end:
  mov R0, 1
  mov [BP-25], R0
__if_2261_end:
  mov R1, 10
  mov [SP], R1
  mov R1, 335
  mov [SP+1], R1
  mov R1, __literal_string_2299
  mov [SP+2], R1
  call __function_print_at
  jmp __if_2253_end
__if_2253_else:
  mov R0, 0
  mov [BP-25], R0
__if_2253_end:
__if_2304_start:
  mov R0, [BP-15]
  jf R0, __if_2304_end
  mov R0, [BP-13]
  iadd R0, 4
  mov [BP-13], R0
__if_2304_end:
  mov R1, 1
  mov [SP], R1
  call __function_select_region
  mov R0, [BP-17]
  mov [BP-29], R0
__while_2317_start:
__while_2317_continue:
  mov R0, [BP-29]
  ine R0, -1
  jf R0, __while_2317_end
__if_2322_start:
  mov R1, [BP-29]
  mov R0, [R1]
  jf R0, __if_2322_end
  mov R2, [BP-29]
  iadd R2, 1
  mov R1, [R2]
  mov [SP], R1
  mov R2, [BP-29]
  iadd R2, 2
  mov R1, [R2]
  mov [SP+1], R1
  call __function_draw_region_at
__if_2322_end:
  mov R1, [BP-29]
  iadd R1, 5
  mov R0, [R1]
  mov [BP-29], R0
  jmp __while_2317_start
__while_2317_end:
__if_2335_start:
  mov R0, [BP-15]
  jf R0, __if_2335_end
  mov R1, 3
  mov [SP], R1
  call __function_select_region
  mov R1, [BP-14]
  mov [SP], R1
  mov R1, [BP-13]
  mov [SP+1], R1
  call __function_draw_region_at
__if_2335_end:
__if_2346_start:
  mov R0, [BP-15]
  jf R0, __LogicalAnd_ShortCircuit_2349
  mov R1, [BP-13]
  igt R1, 360
  and R0, R1
__LogicalAnd_ShortCircuit_2349:
  jf R0, __if_2346_end
  mov R0, 0
  mov [BP-15], R0
__if_2346_end:
  call __function_end_frame
  jmp __while_1613_start
__while_1613_end:
__function_main_return:
  mov SP, BP
  pop BP
  ret

__literal_string_2067:
  string "Mid Fast Paddle"
__literal_string_2091:
  string "Mid Fast Ball"
__literal_string_2115:
  string "Fast Ball"
__literal_string_2133:
  string "Fast Paddle"
__literal_string_2159:
  string "Large Paddle"
__literal_string_2201:
  string "Large Ball"
__literal_string_2249:
  string "Reset Bricks"
__literal_string_2299:
  string "Half Bricks"
