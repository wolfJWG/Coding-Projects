; program start section
  call __global_scope_initialization
  call __function_main
  hlt

; location of global variables
  define global_malloc_start_address 0
  define global_malloc_end_address 1
  define global_malloc_first_block 2
  define global_currentCard 3
  define global_myDeck 4
  define global_playerQueue 5
  define global_robotQueue 6

__global_scope_initialization:
  push BP
  mov BP, SP
  mov R0, 1048576
  mov [global_malloc_start_address], R0
  mov R0, 3145727
  mov [global_malloc_end_address], R0
  mov R0, -1
  mov [global_malloc_first_block], R0
  mov R0, -1
  mov [global_currentCard], R0
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

__function_isdigit:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+2]
  ige R0, 48
  jf R0, __LogicalAnd_ShortCircuit_1307
  mov R1, [BP+2]
  ile R1, 57
  and R0, R1
__LogicalAnd_ShortCircuit_1307:
__function_isdigit_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_isxdigit:
  push BP
  mov BP, SP
  push R1
__if_1312_start:
  mov R0, [BP+2]
  ige R0, 48
  jf R0, __LogicalAnd_ShortCircuit_1317
  mov R1, [BP+2]
  ile R1, 57
  and R0, R1
__LogicalAnd_ShortCircuit_1317:
  jf R0, __if_1312_end
  mov R0, 1
  jmp __function_isxdigit_return
__if_1312_end:
__if_1322_start:
  mov R0, [BP+2]
  ige R0, 97
  jf R0, __LogicalAnd_ShortCircuit_1327
  mov R1, [BP+2]
  ile R1, 102
  and R0, R1
__LogicalAnd_ShortCircuit_1327:
  jf R0, __if_1322_end
  mov R0, 1
  jmp __function_isxdigit_return
__if_1322_end:
  mov R0, [BP+2]
  ige R0, 65
  jf R0, __LogicalAnd_ShortCircuit_1338
  mov R1, [BP+2]
  ile R1, 70
  and R0, R1
__LogicalAnd_ShortCircuit_1338:
__function_isxdigit_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_isalpha:
  push BP
  mov BP, SP
  push R1
__if_1343_start:
  mov R0, [BP+2]
  ige R0, 97
  jf R0, __LogicalAnd_ShortCircuit_1348
  mov R1, [BP+2]
  ile R1, 122
  and R0, R1
__LogicalAnd_ShortCircuit_1348:
  jf R0, __if_1343_end
  mov R0, 1
  jmp __function_isalpha_return
__if_1343_end:
  mov R0, [BP+2]
  ige R0, 65
  jf R0, __LogicalAnd_ShortCircuit_1359
  mov R1, [BP+2]
  ile R1, 90
  and R0, R1
__LogicalAnd_ShortCircuit_1359:
__function_isalpha_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_isascii:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+2]
  ige R0, 0
  jf R0, __LogicalAnd_ShortCircuit_1370
  mov R1, [BP+2]
  ile R1, 127
  and R0, R1
__LogicalAnd_ShortCircuit_1370:
__function_isascii_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_isalphanum:
  push BP
  mov BP, SP
  push R1
__if_1375_start:
  mov R0, [BP+2]
  ige R0, 48
  jf R0, __LogicalAnd_ShortCircuit_1380
  mov R1, [BP+2]
  ile R1, 57
  and R0, R1
__LogicalAnd_ShortCircuit_1380:
  jf R0, __if_1375_end
  mov R0, 1
  jmp __function_isalphanum_return
__if_1375_end:
__if_1385_start:
  mov R0, [BP+2]
  ige R0, 97
  jf R0, __LogicalAnd_ShortCircuit_1390
  mov R1, [BP+2]
  ile R1, 122
  and R0, R1
__LogicalAnd_ShortCircuit_1390:
  jf R0, __if_1385_end
  mov R0, 1
  jmp __function_isalphanum_return
__if_1385_end:
  mov R0, [BP+2]
  ige R0, 65
  jf R0, __LogicalAnd_ShortCircuit_1401
  mov R1, [BP+2]
  ile R1, 90
  and R0, R1
__LogicalAnd_ShortCircuit_1401:
__function_isalphanum_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_islower:
  push BP
  mov BP, SP
  push R1
__if_1406_start:
  mov R0, [BP+2]
  ige R0, 97
  jf R0, __LogicalAnd_ShortCircuit_1411
  mov R1, [BP+2]
  ile R1, 122
  and R0, R1
__LogicalAnd_ShortCircuit_1411:
  jf R0, __if_1406_end
  mov R0, 1
  jmp __function_islower_return
__if_1406_end:
  mov R0, [BP+2]
  ige R0, 224
  jf R0, __LogicalAnd_ShortCircuit_1422
  mov R1, [BP+2]
  ile R1, 254
  and R0, R1
__LogicalAnd_ShortCircuit_1422:
  jf R0, __LogicalAnd_ShortCircuit_1426
  mov R1, [BP+2]
  ine R1, 247
  and R0, R1
__LogicalAnd_ShortCircuit_1426:
__function_islower_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_isupper:
  push BP
  mov BP, SP
  push R1
__if_1431_start:
  mov R0, [BP+2]
  ige R0, 65
  jf R0, __LogicalAnd_ShortCircuit_1436
  mov R1, [BP+2]
  ile R1, 90
  and R0, R1
__LogicalAnd_ShortCircuit_1436:
  jf R0, __if_1431_end
  mov R0, 1
  jmp __function_isupper_return
__if_1431_end:
  mov R0, [BP+2]
  ige R0, 192
  jf R0, __LogicalAnd_ShortCircuit_1447
  mov R1, [BP+2]
  ile R1, 222
  and R0, R1
__LogicalAnd_ShortCircuit_1447:
  jf R0, __LogicalAnd_ShortCircuit_1451
  mov R1, [BP+2]
  ine R1, 215
  and R0, R1
__LogicalAnd_ShortCircuit_1451:
__function_isupper_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_isspace:
  push BP
  mov BP, SP
  push R1
  mov R0, [BP+2]
  ieq R0, 32
  jt R0, __LogicalOr_ShortCircuit_1462
  mov R1, [BP+2]
  ieq R1, 10
  or R0, R1
__LogicalOr_ShortCircuit_1462:
  jt R0, __LogicalOr_ShortCircuit_1466
  mov R1, [BP+2]
  ieq R1, 13
  or R0, R1
__LogicalOr_ShortCircuit_1466:
  jt R0, __LogicalOr_ShortCircuit_1470
  mov R1, [BP+2]
  ieq R1, 9
  or R0, R1
__LogicalOr_ShortCircuit_1470:
__function_isspace_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_tolower:
  push BP
  mov BP, SP
  push R1
  push R2
  isub SP, 1
__if_1475_start:
  mov R2, [BP+2]
  mov [SP], R2
  call __function_isupper
  mov R1, R0
  bnot R1
  mov R0, R1
  jf R0, __if_1475_end
  mov R0, [BP+2]
  jmp __function_tolower_return
__if_1475_end:
  mov R0, [BP+2]
  iadd R0, 32
__function_tolower_return:
  iadd SP, 1
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_toupper:
  push BP
  mov BP, SP
  push R1
  push R2
  isub SP, 1
__if_1487_start:
  mov R2, [BP+2]
  mov [SP], R2
  call __function_islower
  mov R1, R0
  bnot R1
  mov R0, R1
  jf R0, __if_1487_end
  mov R0, [BP+2]
  jmp __function_toupper_return
__if_1487_end:
  mov R0, [BP+2]
  isub R0, 32
__function_toupper_return:
  iadd SP, 1
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_strlen:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  mov R0, [BP+2]
  mov [BP-1], R0
__while_1502_start:
__while_1502_continue:
  mov R0, [BP+2]
  mov R0, [R0]
  cib R0
  jf R0, __while_1502_end
  mov R0, [BP+2]
  iadd R0, 1
  mov [BP+2], R0
  jmp __while_1502_start
__while_1502_end:
  mov R0, [BP+2]
  mov R1, [BP-1]
  isub R0, R1
__function_strlen_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_strcmp:
  push BP
  mov BP, SP
  push R1
__while_1514_start:
__while_1514_continue:
  mov R0, [BP+2]
  mov R0, [R0]
  cib R0
  jf R0, __LogicalAnd_ShortCircuit_1517
  mov R1, [BP+3]
  mov R1, [R1]
  cib R1
  and R0, R1
__LogicalAnd_ShortCircuit_1517:
  jf R0, __while_1514_end
__if_1521_start:
  mov R0, [BP+2]
  mov R0, [R0]
  mov R1, [BP+3]
  mov R1, [R1]
  ine R0, R1
  jf R0, __if_1521_end
  jmp __while_1514_end
__if_1521_end:
  mov R0, [BP+2]
  iadd R0, 1
  mov [BP+2], R0
  mov R0, [BP+3]
  iadd R0, 1
  mov [BP+3], R0
  jmp __while_1514_start
__while_1514_end:
  mov R0, [BP+2]
  mov R0, [R0]
  mov R1, [BP+3]
  mov R1, [R1]
  isub R0, R1
__function_strcmp_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_strncmp:
  push BP
  mov BP, SP
  push R1
__if_1542_start:
  mov R0, [BP+4]
  ilt R0, 1
  jf R0, __if_1542_end
  mov R0, 0
  jmp __function_strncmp_return
__if_1542_end:
__while_1548_start:
__while_1548_continue:
  mov R0, [BP+2]
  mov R0, [R0]
  cib R0
  jf R0, __LogicalAnd_ShortCircuit_1551
  mov R1, [BP+3]
  mov R1, [R1]
  cib R1
  and R0, R1
__LogicalAnd_ShortCircuit_1551:
  jf R0, __while_1548_end
  mov R0, [BP+4]
  isub R0, 1
  mov [BP+4], R0
__if_1557_start:
  mov R0, [BP+4]
  ile R0, 0
  jf R0, __if_1557_end
  jmp __while_1548_end
__if_1557_end:
__if_1562_start:
  mov R0, [BP+2]
  mov R0, [R0]
  mov R1, [BP+3]
  mov R1, [R1]
  ine R0, R1
  jf R0, __if_1562_end
  jmp __while_1548_end
__if_1562_end:
  mov R0, [BP+2]
  iadd R0, 1
  mov [BP+2], R0
  mov R0, [BP+3]
  iadd R0, 1
  mov [BP+3], R0
  jmp __while_1548_start
__while_1548_end:
  mov R0, [BP+2]
  mov R0, [R0]
  mov R1, [BP+3]
  mov R1, [R1]
  isub R0, R1
__function_strncmp_return:
  pop R1
  mov SP, BP
  pop BP
  ret

__function_strcpy:
  push BP
  mov BP, SP
__while_1582_start:
__while_1582_continue:
  mov R0, [BP+3]
  mov R0, [R0]
  cib R0
  jf R0, __while_1582_end
  mov R0, [BP+3]
  mov R0, [R0]
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP+2]
  iadd R0, 1
  mov [BP+2], R0
  mov R0, [BP+3]
  iadd R0, 1
  mov [BP+3], R0
  jmp __while_1582_start
__while_1582_end:
  mov R0, 0
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
__function_strcpy_return:
  mov SP, BP
  pop BP
  ret

__function_strncpy:
  push BP
  mov BP, SP
__if_1603_start:
  mov R0, [BP+4]
  ilt R0, 1
  jf R0, __if_1603_end
  jmp __function_strncpy_return
__if_1603_end:
__while_1608_start:
__while_1608_continue:
  mov R0, [BP+3]
  mov R0, [R0]
  cib R0
  jf R0, __while_1608_end
  mov R0, [BP+3]
  mov R0, [R0]
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP+2]
  iadd R0, 1
  mov [BP+2], R0
  mov R0, [BP+3]
  iadd R0, 1
  mov [BP+3], R0
  mov R0, [BP+4]
  isub R0, 1
  mov [BP+4], R0
__if_1623_start:
  mov R0, [BP+4]
  ile R0, 0
  jf R0, __if_1623_end
  jmp __while_1608_end
__if_1623_end:
  jmp __while_1608_start
__while_1608_end:
  mov R0, 0
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
__function_strncpy_return:
  mov SP, BP
  pop BP
  ret

__function_strcat:
  push BP
  mov BP, SP
__while_1635_start:
__while_1635_continue:
  mov R0, [BP+2]
  mov R0, [R0]
  cib R0
  jf R0, __while_1635_end
  mov R0, [BP+2]
  iadd R0, 1
  mov [BP+2], R0
  jmp __while_1635_start
__while_1635_end:
__while_1640_start:
__while_1640_continue:
  mov R0, [BP+3]
  mov R0, [R0]
  cib R0
  jf R0, __while_1640_end
  mov R0, [BP+3]
  mov R0, [R0]
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP+2]
  iadd R0, 1
  mov [BP+2], R0
  mov R0, [BP+3]
  iadd R0, 1
  mov [BP+3], R0
  jmp __while_1640_start
__while_1640_end:
  mov R0, 0
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
__function_strcat_return:
  mov SP, BP
  pop BP
  ret

__function_strncat:
  push BP
  mov BP, SP
__if_1661_start:
  mov R0, [BP+4]
  ilt R0, 1
  jf R0, __if_1661_end
  jmp __function_strncat_return
__if_1661_end:
__while_1666_start:
__while_1666_continue:
  mov R0, [BP+2]
  mov R0, [R0]
  cib R0
  jf R0, __while_1666_end
  mov R0, [BP+2]
  iadd R0, 1
  mov [BP+2], R0
  jmp __while_1666_start
__while_1666_end:
__while_1671_start:
__while_1671_continue:
  mov R0, [BP+3]
  mov R0, [R0]
  cib R0
  jf R0, __while_1671_end
  mov R0, [BP+3]
  mov R0, [R0]
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP+2]
  iadd R0, 1
  mov [BP+2], R0
  mov R0, [BP+3]
  iadd R0, 1
  mov [BP+3], R0
  mov R0, [BP+4]
  isub R0, 1
  mov [BP+4], R0
__if_1686_start:
  mov R0, [BP+4]
  ile R0, 0
  jf R0, __if_1686_end
  jmp __while_1671_end
__if_1686_end:
  jmp __while_1671_start
__while_1671_end:
  mov R0, 0
  lea R1, [BP+2]
  mov R1, [R1]
  mov [R1], R0
__function_strncat_return:
  mov SP, BP
  pop BP
  ret

__function_itoa:
  push BP
  mov BP, SP
  isub SP, 51
  lea DR, [BP-17]
  mov SR, __literal_string_1704
  mov CR, 17
  movs
__if_1708_start:
  mov R0, [BP+4]
  ilt R0, 2
  jt R0, __LogicalOr_ShortCircuit_1713
  mov R1, [BP+4]
  igt R1, 16
  or R0, R1
__LogicalOr_ShortCircuit_1713:
  jf R0, __if_1708_end
  jmp __function_itoa_return
__if_1708_end:
__if_1717_start:
  mov R0, [BP+4]
  ieq R0, 10
  jf R0, __LogicalAnd_ShortCircuit_1722
  mov R1, [BP+2]
  ilt R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_1722:
  jf R0, __if_1717_end
  mov R0, 45
  lea R1, [BP+3]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP+3]
  iadd R0, 1
  mov [BP+3], R0
  mov R0, [BP+2]
  isgn R0
  mov [BP+2], R0
__if_1717_end:
  lea R0, [BP-50]
  mov [BP-51], R0
__do_1739_start:
  lea R0, [BP-17]
  mov R1, [BP+2]
  mov R2, [BP+4]
  imod R1, R2
  iadd R0, R1
  mov R0, [R0]
  lea R1, [BP-51]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP-51]
  iadd R0, 1
  mov [BP-51], R0
  mov R0, [BP+2]
  mov R1, [BP+4]
  idiv R0, R1
  mov [BP+2], R0
__do_1739_continue:
  mov R0, [BP+2]
  cib R0
  jt R0, __do_1739_start
__do_1739_end:
__do_1755_start:
  mov R0, [BP-51]
  isub R0, 1
  mov [BP-51], R0
  mov R0, [BP-51]
  mov R0, [R0]
  lea R1, [BP+3]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP+3]
  iadd R0, 1
  mov [BP+3], R0
__do_1755_continue:
  mov R0, [BP-51]
  lea R1, [BP-50]
  ine R0, R1
  jt R0, __do_1755_start
__do_1755_end:
  mov R0, 0
  lea R1, [BP+3]
  mov R1, [R1]
  mov [R1], R0
__function_itoa_return:
  mov SP, BP
  pop BP
  ret

__function_ftoa:
  push BP
  mov BP, SP
  isub SP, 14
__if_1779_start:
  mov R0, [BP+2]
  flt R0, 0.000000
  jf R0, __if_1779_end
  mov R0, 45
  lea R1, [BP+3]
  mov R1, [R1]
  mov [R1], R0
  mov R0, [BP+3]
  iadd R0, 1
  mov [BP+3], R0
  mov R0, [BP+2]
  fsgn R0
  mov [BP+2], R0
__if_1779_end:
  mov R0, [BP+2]
  flr R0
  cfi R0
  mov [BP-1], R0
  push R1
  mov R0, [BP+2]
  mov R1, [BP-1]
  cif R1
  fsub R0, R1
  fmul R0, 100000.0
  round R0
  cfi R0
  mov [BP-2], R0
  pop R1
  mov R1, [BP-1]
  mov [SP], R1
  mov R1, [BP+3]
  mov [SP+1], R1
  mov R1, 10
  mov [SP+2], R1
  call __function_itoa
__if_1808_start:
  mov R0, [BP-2]
  bnot R0
  jf R0, __if_1808_end
  jmp __function_ftoa_return
__if_1808_end:
  mov R1, [BP+3]
  mov [SP], R1
  mov R1, __literal_string_1814
  mov [SP+1], R1
  call __function_strcat
  mov R0, [BP-2]
  mov [BP-3], R0
__while_1818_start:
__while_1818_continue:
  mov R0, [BP-3]
  ilt R0, 10000
  jf R0, __while_1818_end
  mov R1, [BP+3]
  mov [SP], R1
  mov R1, __literal_string_1825
  mov [SP+1], R1
  call __function_strcat
  mov R0, [BP-3]
  imul R0, 10
  mov [BP-3], R0
  jmp __while_1818_start
__while_1818_end:
__while_1829_start:
__while_1829_continue:
  mov R0, [BP-2]
  imod R0, 10
  bnot R0
  jf R0, __while_1829_end
  mov R0, [BP-2]
  idiv R0, 10
  mov [BP-2], R0
  jmp __while_1829_start
__while_1829_end:
  mov R1, [BP-2]
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  mov R1, 10
  mov [SP+2], R1
  call __function_itoa
  mov R1, [BP+3]
  mov [SP], R1
  lea R1, [BP-11]
  mov [SP+1], R1
  call __function_strcat
__function_ftoa_return:
  mov SP, BP
  pop BP
  ret

__function_createDeck:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  push R2
  isub SP, 1
  mov R2, 3
  mov [SP], R2
  call __function_malloc
  mov R1, R0
  mov R0, R1
  mov [BP-1], R0
  mov R0, -1
  mov R1, [BP-1]
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-1]
  iadd R1, 1
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-1]
__function_createDeck_return:
  iadd SP, 1
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_createQueue:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  push R2
  isub SP, 1
  mov R2, 3
  mov [SP], R2
  call __function_malloc
  mov R1, R0
  mov R0, R1
  mov [BP-1], R0
  mov R0, -1
  mov R1, [BP-1]
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP-1]
  mov [R1], R0
  mov R0, 0
  mov R1, [BP-1]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP-1]
__function_createQueue_return:
  iadd SP, 1
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_addCardToDeck:
  push BP
  mov BP, SP
  isub SP, 2
  mov R2, 4
  mov [SP], R2
  call __function_malloc
  mov R1, R0
  mov R0, R1
  mov [BP-1], R0
  mov R0, [BP+3]
  mov R1, [BP-1]
  mov [R1], R0
  mov R0, [BP+4]
  mov R1, [BP-1]
  iadd R1, 1
  mov [R1], R0
  mov R0, -1
  mov R1, [BP-1]
  iadd R1, 2
  mov [R1], R0
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  mov R1, [BP-1]
  iadd R1, 3
  mov [R1], R0
__if_1945_start:
  mov R1, [BP+2]
  iadd R1, 1
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_1945_end
  mov R0, [BP-1]
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  iadd R1, 2
  mov [R1], R0
__if_1945_end:
  mov R0, [BP-1]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
__if_1960_start:
  mov R1, [BP+2]
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_1960_end
  mov R0, [BP-1]
  mov R1, [BP+2]
  mov [R1], R0
__if_1960_end:
  mov R2, [BP+2]
  iadd R2, 2
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
__function_addCardToDeck_return:
  mov SP, BP
  pop BP
  ret

__function_enqueue:
  push BP
  mov BP, SP
  mov R0, -1
  mov R1, [BP+3]
  iadd R1, 2
  mov [R1], R0
__if_1980_start:
  mov R1, [BP+2]
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_1980_else
  mov R0, [BP+3]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
  mov R1, [BP+2]
  mov [R1], R0
  jmp __if_1980_end
__if_1980_else:
  mov R0, [BP+3]
  mov R2, [BP+2]
  iadd R2, 1
  mov R1, [R2]
  iadd R1, 2
  mov [R1], R0
  mov R0, [BP+3]
  mov R1, [BP+2]
  iadd R1, 1
  mov [R1], R0
__if_1980_end:
  mov R2, [BP+2]
  iadd R2, 2
  mov R0, [R2]
  mov R1, R0
  iadd R1, 1
  mov [R2], R1
__function_enqueue_return:
  mov SP, BP
  pop BP
  ret

__function_dequeue:
  push BP
  mov BP, SP
  isub SP, 1
  push R1
  push R2
__if_2008_start:
  mov R1, [BP+2]
  mov R0, [R1]
  ieq R0, -1
  jf R0, __if_2008_end
  mov R0, -1
  jmp __function_dequeue_return
__if_2008_end:
  mov R1, [BP+2]
  mov R0, [R1]
  mov [BP-1], R0
  mov R1, [BP-1]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP+2]
  mov [R1], R0
  mov R2, [BP+2]
  iadd R2, 2
  mov R0, [R2]
  mov R1, R0
  isub R1, 1
  mov [R2], R1
  mov R0, [BP-1]
__function_dequeue_return:
  pop R2
  pop R1
  mov SP, BP
  pop BP
  ret

__function_populateQueue:
  push BP
  mov BP, SP
  isub SP, 4
  mov R0, 0
  mov [BP-1], R0
__for_2034_start:
  mov R0, [BP-1]
  mov R1, [BP+4]
  ilt R0, R1
  jf R0, __for_2034_end
__if_2044_start:
  mov R1, [BP+3]
  mov R0, [R1]
  ine R0, -1
  jf R0, __if_2044_end
  mov R1, [BP+3]
  mov R0, [R1]
  mov [BP-2], R0
  mov R2, [BP+3]
  mov R1, [R2]
  iadd R1, 2
  mov R0, [R1]
  mov R1, [BP+3]
  mov [R1], R0
  mov R1, [BP+2]
  mov [SP], R1
  mov R1, [BP-2]
  mov [SP+1], R1
  call __function_enqueue
  mov R2, [BP+3]
  iadd R2, 2
  mov R0, [R2]
  mov R1, R0
  isub R1, 1
  mov [R2], R1
__if_2044_end:
__for_2034_continue:
  mov R0, [BP-1]
  mov R1, R0
  iadd R1, 1
  mov [BP-1], R1
  jmp __for_2034_start
__for_2034_end:
__function_populateQueue_return:
  mov SP, BP
  pop BP
  ret

__function_main:
  push BP
  mov BP, SP
  isub SP, 146
  mov R1, 0
  mov [SP], R1
  call __function_select_texture
  mov R0, 32
  mov [BP-1], R0
  mov R0, 47
  mov [BP-2], R0
  mov R0, 1
  mov [BP-114], R0
__for_2075_start:
  mov R0, [BP-114]
  ile R0, 52
  jf R0, __for_2075_end
  mov R1, [BP-114]
  mov [SP], R1
  call __function_select_region
  mov R1, [BP-114]
  isub R1, 1
  mov R2, [BP-1]
  imul R1, R2
  mov [SP], R1
  mov R1, 0
  mov [SP+1], R1
  mov R1, [BP-114]
  mov R2, [BP-1]
  imul R1, R2
  isub R1, 1
  mov [SP+2], R1
  mov R1, [BP-2]
  mov [SP+3], R1
  call __function_define_region_topleft
__if_2102_start:
  mov R0, [BP-114]
  ige R0, 14
  jf R0, __LogicalAnd_ShortCircuit_2107
  mov R1, [BP-114]
  ile R1, 26
  and R0, R1
__LogicalAnd_ShortCircuit_2107:
  jf R0, __if_2102_else
  mov R1, [BP-114]
  isub R1, 1
  isub R1, 13
  mov R2, [BP-1]
  imul R1, R2
  mov [SP], R1
  mov R1, 48
  mov [SP+1], R1
  mov R1, [BP-114]
  isub R1, 13
  mov R2, [BP-1]
  imul R1, R2
  isub R1, 1
  mov [SP+2], R1
  mov R1, [BP-2]
  iadd R1, 48
  mov [SP+3], R1
  call __function_define_region_topleft
  jmp __if_2102_end
__if_2102_else:
__if_2134_start:
  mov R0, [BP-114]
  ige R0, 17
  jf R0, __LogicalAnd_ShortCircuit_2139
  mov R1, [BP-114]
  ile R1, 39
  and R0, R1
__LogicalAnd_ShortCircuit_2139:
  jf R0, __if_2134_else
  mov R1, [BP-114]
  isub R1, 1
  isub R1, 26
  mov R2, [BP-1]
  imul R1, R2
  mov [SP], R1
  mov R1, 96
  mov [SP+1], R1
  mov R1, [BP-114]
  isub R1, 26
  mov R2, [BP-1]
  imul R1, R2
  isub R1, 1
  mov [SP+2], R1
  mov R1, [BP-2]
  iadd R1, 96
  mov [SP+3], R1
  call __function_define_region_topleft
  jmp __if_2134_end
__if_2134_else:
__if_2166_start:
  mov R0, [BP-114]
  ige R0, 30
  jf R0, __LogicalAnd_ShortCircuit_2171
  mov R1, [BP-114]
  ile R1, 52
  and R0, R1
__LogicalAnd_ShortCircuit_2171:
  jf R0, __if_2166_end
  mov R1, [BP-114]
  isub R1, 1
  isub R1, 39
  mov R2, [BP-1]
  imul R1, R2
  mov [SP], R1
  mov R1, 144
  mov [SP+1], R1
  mov R1, [BP-114]
  isub R1, 39
  mov R2, [BP-1]
  imul R1, R2
  isub R1, 1
  mov [SP+2], R1
  mov R1, [BP-2]
  iadd R1, 144
  mov [SP+3], R1
  call __function_define_region_topleft
__if_2166_end:
__if_2134_end:
__if_2102_end:
__for_2075_continue:
  mov R0, [BP-114]
  mov R1, R0
  iadd R1, 1
  mov [BP-114], R1
  jmp __for_2075_start
__for_2075_end:
  mov R1, 60
  mov [SP], R1
  call __function_select_region
  mov R1, 32
  mov [SP], R1
  mov R1, 192
  mov [SP+1], R1
  mov R1, 64
  mov [SP+2], R1
  mov R1, 241
  mov [SP+3], R1
  call __function_define_region_topleft
  call __function_get_time
  mov R1, R0
  mov [BP-142], R1
  mov R1, [BP-142]
  mov [SP], R1
  call __function_srand
  mov R0, 2
  mov [BP-54], R0
  mov R0, 3
  mov [BP-53], R0
  mov R0, 4
  mov [BP-52], R0
  mov R0, 5
  mov [BP-51], R0
  mov R0, 6
  mov [BP-50], R0
  mov R0, 7
  mov [BP-49], R0
  mov R0, 8
  mov [BP-48], R0
  mov R0, 9
  mov [BP-47], R0
  mov R0, 10
  mov [BP-46], R0
  mov R0, 11
  mov [BP-45], R0
  mov R0, 12
  mov [BP-44], R0
  mov R0, 13
  mov [BP-43], R0
  mov R0, 14
  mov [BP-42], R0
  mov R0, 2
  mov [BP-41], R0
  mov R0, 3
  mov [BP-40], R0
  mov R0, 4
  mov [BP-39], R0
  mov R0, 5
  mov [BP-38], R0
  mov R0, 6
  mov [BP-37], R0
  mov R0, 7
  mov [BP-36], R0
  mov R0, 8
  mov [BP-35], R0
  mov R0, 9
  mov [BP-34], R0
  mov R0, 10
  mov [BP-33], R0
  mov R0, 11
  mov [BP-32], R0
  mov R0, 12
  mov [BP-31], R0
  mov R0, 13
  mov [BP-30], R0
  mov R0, 14
  mov [BP-29], R0
  mov R0, 2
  mov [BP-28], R0
  mov R0, 3
  mov [BP-27], R0
  mov R0, 4
  mov [BP-26], R0
  mov R0, 5
  mov [BP-25], R0
  mov R0, 6
  mov [BP-24], R0
  mov R0, 7
  mov [BP-23], R0
  mov R0, 8
  mov [BP-22], R0
  mov R0, 9
  mov [BP-21], R0
  mov R0, 10
  mov [BP-20], R0
  mov R0, 11
  mov [BP-19], R0
  mov R0, 12
  mov [BP-18], R0
  mov R0, 13
  mov [BP-17], R0
  mov R0, 14
  mov [BP-16], R0
  mov R0, 2
  mov [BP-15], R0
  mov R0, 3
  mov [BP-14], R0
  mov R0, 4
  mov [BP-13], R0
  mov R0, 5
  mov [BP-12], R0
  mov R0, 6
  mov [BP-11], R0
  mov R0, 7
  mov [BP-10], R0
  mov R0, 8
  mov [BP-9], R0
  mov R0, 9
  mov [BP-8], R0
  mov R0, 10
  mov [BP-7], R0
  mov R0, 11
  mov [BP-6], R0
  mov R0, 12
  mov [BP-5], R0
  mov R0, 13
  mov [BP-4], R0
  mov R0, 14
  mov [BP-3], R0
  mov R0, 1
  mov [BP-106], R0
  mov R0, 2
  mov [BP-105], R0
  mov R0, 3
  mov [BP-104], R0
  mov R0, 4
  mov [BP-103], R0
  mov R0, 5
  mov [BP-102], R0
  mov R0, 6
  mov [BP-101], R0
  mov R0, 7
  mov [BP-100], R0
  mov R0, 8
  mov [BP-99], R0
  mov R0, 9
  mov [BP-98], R0
  mov R0, 10
  mov [BP-97], R0
  mov R0, 11
  mov [BP-96], R0
  mov R0, 12
  mov [BP-95], R0
  mov R0, 13
  mov [BP-94], R0
  mov R0, 14
  mov [BP-93], R0
  mov R0, 15
  mov [BP-92], R0
  mov R0, 16
  mov [BP-91], R0
  mov R0, 17
  mov [BP-90], R0
  mov R0, 18
  mov [BP-89], R0
  mov R0, 19
  mov [BP-88], R0
  mov R0, 20
  mov [BP-87], R0
  mov R0, 21
  mov [BP-86], R0
  mov R0, 22
  mov [BP-85], R0
  mov R0, 23
  mov [BP-84], R0
  mov R0, 24
  mov [BP-83], R0
  mov R0, 25
  mov [BP-82], R0
  mov R0, 26
  mov [BP-81], R0
  mov R0, 27
  mov [BP-80], R0
  mov R0, 28
  mov [BP-79], R0
  mov R0, 29
  mov [BP-78], R0
  mov R0, 30
  mov [BP-77], R0
  mov R0, 31
  mov [BP-76], R0
  mov R0, 32
  mov [BP-75], R0
  mov R0, 33
  mov [BP-74], R0
  mov R0, 34
  mov [BP-73], R0
  mov R0, 35
  mov [BP-72], R0
  mov R0, 36
  mov [BP-71], R0
  mov R0, 37
  mov [BP-70], R0
  mov R0, 38
  mov [BP-69], R0
  mov R0, 39
  mov [BP-68], R0
  mov R0, 40
  mov [BP-67], R0
  mov R0, 41
  mov [BP-66], R0
  mov R0, 42
  mov [BP-65], R0
  mov R0, 43
  mov [BP-64], R0
  mov R0, 44
  mov [BP-63], R0
  mov R0, 45
  mov [BP-62], R0
  mov R0, 46
  mov [BP-61], R0
  mov R0, 47
  mov [BP-60], R0
  mov R0, 48
  mov [BP-59], R0
  mov R0, 49
  mov [BP-58], R0
  mov R0, 50
  mov [BP-57], R0
  mov R0, 51
  mov [BP-56], R0
  mov R0, 52
  mov [BP-55], R0
  mov R0, 51
  mov [BP-114], R0
__for_2319_start:
  mov R0, [BP-114]
  ige R0, 0
  jf R0, __for_2319_end
  call __function_rand
  mov R1, R0
  mov R2, [BP-114]
  iadd R2, 1
  imod R1, R2
  mov R0, R1
  mov [BP-115], R0
  lea R0, [BP-106]
  mov R1, [BP-114]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-116], R0
  lea R0, [BP-54]
  mov R1, [BP-114]
  iadd R0, R1
  mov R0, [R0]
  mov [BP-117], R0
  lea R0, [BP-106]
  mov R1, [BP-115]
  iadd R0, R1
  mov R0, [R0]
  lea R1, [BP-106]
  mov R2, [BP-114]
  iadd R1, R2
  mov [R1], R0
  lea R0, [BP-54]
  mov R1, [BP-115]
  iadd R0, R1
  mov R0, [R0]
  lea R1, [BP-54]
  mov R2, [BP-114]
  iadd R1, R2
  mov [R1], R0
  mov R0, [BP-116]
  lea R1, [BP-106]
  mov R2, [BP-115]
  iadd R1, R2
  mov [R1], R0
  mov R0, [BP-117]
  lea R1, [BP-54]
  mov R2, [BP-115]
  iadd R1, R2
  mov [R1], R0
__for_2319_continue:
  mov R0, [BP-114]
  mov R1, R0
  isub R1, 1
  mov [BP-114], R1
  jmp __for_2319_start
__for_2319_end:
  call __function_createDeck
  mov R1, R0
  mov [global_myDeck], R1
  mov R0, R1
  call __function_createQueue
  mov R1, R0
  mov [global_playerQueue], R1
  mov R0, R1
  call __function_createQueue
  mov R1, R0
  mov [global_robotQueue], R1
  mov R0, R1
  mov R0, 0
  mov [BP-114], R0
__for_2380_start:
  mov R0, [BP-114]
  ilt R0, 52
  jf R0, __for_2380_end
  mov R1, [global_myDeck]
  mov [SP], R1
  lea R1, [BP-106]
  mov R2, [BP-114]
  iadd R1, R2
  mov R1, [R1]
  mov [SP+1], R1
  lea R1, [BP-54]
  mov R2, [BP-114]
  iadd R1, R2
  mov R1, [R1]
  mov [SP+2], R1
  call __function_addCardToDeck
__for_2380_continue:
  mov R0, [BP-114]
  mov R1, R0
  iadd R1, 1
  mov [BP-114], R1
  jmp __for_2380_start
__for_2380_end:
  mov R1, [global_myDeck]
  mov R0, [R1]
  mov [global_currentCard], R0
  mov R1, [global_playerQueue]
  mov [SP], R1
  mov R1, [global_myDeck]
  mov [SP+1], R1
  mov R1, 26
  mov [SP+2], R1
  call __function_populateQueue
  mov R1, [global_robotQueue]
  mov [SP], R1
  mov R1, [global_myDeck]
  mov [SP+1], R1
  mov R1, 26
  mov [SP+2], R1
  call __function_populateQueue
  mov R1, 0
  mov [SP], R1
  call __function_select_gamepad
  mov R0, 0
  mov [BP-111], R0
  mov R0, 1
  mov [BP-112], R0
  mov R0, 0
  mov [BP-113], R0
__while_2429_start:
__while_2429_continue:
  mov R0, 1
  jf R0, __while_2429_end
  mov R2, 123
  mov [SP], R2
  mov R2, 172
  mov [SP+1], R2
  mov R2, 200
  mov [SP+2], R2
  call __function_make_color_rgb
  mov R1, R0
  mov [BP-142], R1
  mov R1, [BP-142]
  mov [SP], R1
  call __function_clear_screen
  call __function_gamepad_button_start
  mov R1, R0
  ieq R1, 1
  mov R0, R1
  mov [BP-114], R0
  call __function_gamepad_down
  mov R1, R0
  ieq R1, 1
  mov R0, R1
  mov [BP-115], R0
__if_2449_start:
  mov R0, [BP-114]
  jf R0, __if_2449_end
  mov R0, 0
  mov [BP-112], R0
__if_2455_start:
  mov R1, [global_playerQueue]
  iadd R1, 2
  mov R0, [R1]
  igt R0, 0
  jf R0, __LogicalAnd_ShortCircuit_2462
  mov R2, [global_robotQueue]
  iadd R2, 2
  mov R1, [R2]
  igt R1, 0
  and R0, R1
__LogicalAnd_ShortCircuit_2462:
  jf R0, __LogicalAnd_ShortCircuit_2466
  mov R1, [BP-107]
  ine R1, -1
  and R0, R1
__LogicalAnd_ShortCircuit_2466:
  jf R0, __LogicalAnd_ShortCircuit_2470
  mov R1, [BP-108]
  ine R1, -1
  and R0, R1
__LogicalAnd_ShortCircuit_2470:
  jf R0, __if_2455_end
  mov R2, [global_playerQueue]
  mov [SP], R2
  call __function_dequeue
  mov R1, R0
  mov [BP-107], R1
  mov R0, R1
  mov R2, [global_robotQueue]
  mov [SP], R2
  call __function_dequeue
  mov R1, R0
  mov [BP-108], R1
  mov R0, R1
__if_2482_start:
  mov R1, [BP-107]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP-108]
  iadd R2, 1
  mov R1, [R2]
  igt R0, R1
  jf R0, __if_2482_else
  mov R1, [global_playerQueue]
  mov [SP], R1
  mov R1, [BP-107]
  mov [SP+1], R1
  call __function_enqueue
  mov R1, [global_playerQueue]
  mov [SP], R1
  mov R1, [BP-108]
  mov [SP+1], R1
  call __function_enqueue
  mov R0, 0
  mov [BP-111], R0
  jmp __if_2482_end
__if_2482_else:
__if_2498_start:
  mov R1, [BP-107]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP-108]
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_2498_else
  mov R1, [global_robotQueue]
  mov [SP], R1
  mov R1, [BP-108]
  mov [SP+1], R1
  call __function_enqueue
  mov R1, [global_robotQueue]
  mov [SP], R1
  mov R1, [BP-107]
  mov [SP+1], R1
  call __function_enqueue
  mov R0, 0
  mov [BP-111], R0
  jmp __if_2498_end
__if_2498_else:
__if_2514_start:
  mov R1, [BP-107]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP-108]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_2514_end
__if_2521_start:
  mov R1, [global_playerQueue]
  iadd R1, 2
  mov R0, [R1]
  ige R0, 3
  jf R0, __LogicalAnd_ShortCircuit_2528
  mov R2, [global_robotQueue]
  iadd R2, 2
  mov R1, [R2]
  ige R1, 3
  and R0, R1
__LogicalAnd_ShortCircuit_2528:
  jf R0, __if_2521_end
  mov R0, 1
  mov [BP-111], R0
  mov R2, [global_playerQueue]
  mov [SP], R2
  call __function_dequeue
  mov R1, R0
  mov [BP-109], R1
  mov R0, R1
  mov R2, [global_robotQueue]
  mov [SP], R2
  call __function_dequeue
  mov R1, R0
  mov [BP-110], R1
  mov R0, R1
  mov R1, [global_playerQueue]
  mov [SP], R1
  call __function_dequeue
  mov [BP-136], R0
  mov R1, [global_playerQueue]
  mov [SP], R1
  call __function_dequeue
  mov [BP-137], R0
  mov R1, [global_playerQueue]
  mov [SP], R1
  call __function_dequeue
  mov [BP-138], R0
  mov R1, [global_robotQueue]
  mov [SP], R1
  call __function_dequeue
  mov [BP-139], R0
  mov R1, [global_robotQueue]
  mov [SP], R1
  call __function_dequeue
  mov [BP-140], R0
  mov R1, [global_robotQueue]
  mov [SP], R1
  call __function_dequeue
  mov [BP-141], R0
__if_2567_start:
  mov R1, [BP-109]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP-110]
  iadd R2, 1
  mov R1, [R2]
  ieq R0, R1
  jf R0, __if_2567_else
  mov R1, [global_robotQueue]
  mov [SP], R1
  mov R1, [BP-108]
  mov [SP+1], R1
  call __function_enqueue
  mov R1, [global_robotQueue]
  mov [SP], R1
  mov R1, [BP-110]
  mov [SP+1], R1
  call __function_enqueue
  mov R1, [global_robotQueue]
  mov [SP], R1
  mov R1, [BP-139]
  mov [SP+1], R1
  call __function_enqueue
  mov R1, [global_robotQueue]
  mov [SP], R1
  mov R1, [BP-140]
  mov [SP+1], R1
  call __function_enqueue
  mov R1, [global_robotQueue]
  mov [SP], R1
  mov R1, [BP-141]
  mov [SP+1], R1
  call __function_enqueue
  mov R1, [global_playerQueue]
  mov [SP], R1
  mov R1, [BP-107]
  mov [SP+1], R1
  call __function_enqueue
  mov R1, [global_playerQueue]
  mov [SP], R1
  mov R1, [BP-109]
  mov [SP+1], R1
  call __function_enqueue
  mov R1, [global_playerQueue]
  mov [SP], R1
  mov R1, [BP-136]
  mov [SP+1], R1
  call __function_enqueue
  mov R1, [global_playerQueue]
  mov [SP], R1
  mov R1, [BP-137]
  mov [SP+1], R1
  call __function_enqueue
  mov R1, [global_playerQueue]
  mov [SP], R1
  mov R1, [BP-138]
  mov [SP+1], R1
  call __function_enqueue
  jmp __if_2567_end
__if_2567_else:
__if_2604_start:
  mov R1, [BP-109]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP-110]
  iadd R2, 1
  mov R1, [R2]
  igt R0, R1
  jf R0, __if_2604_else
  mov R1, [global_playerQueue]
  mov [SP], R1
  mov R1, [BP-107]
  mov [SP+1], R1
  call __function_enqueue
  mov R1, [global_playerQueue]
  mov [SP], R1
  mov R1, [BP-109]
  mov [SP+1], R1
  call __function_enqueue
  mov R1, [global_playerQueue]
  mov [SP], R1
  mov R1, [BP-136]
  mov [SP+1], R1
  call __function_enqueue
  mov R1, [global_playerQueue]
  mov [SP], R1
  mov R1, [BP-137]
  mov [SP+1], R1
  call __function_enqueue
  mov R1, [global_playerQueue]
  mov [SP], R1
  mov R1, [BP-138]
  mov [SP+1], R1
  call __function_enqueue
  mov R1, [global_playerQueue]
  mov [SP], R1
  mov R1, [BP-108]
  mov [SP+1], R1
  call __function_enqueue
  mov R1, [global_playerQueue]
  mov [SP], R1
  mov R1, [BP-110]
  mov [SP+1], R1
  call __function_enqueue
  mov R1, [global_playerQueue]
  mov [SP], R1
  mov R1, [BP-139]
  mov [SP+1], R1
  call __function_enqueue
  mov R1, [global_playerQueue]
  mov [SP], R1
  mov R1, [BP-140]
  mov [SP+1], R1
  call __function_enqueue
  mov R1, [global_playerQueue]
  mov [SP], R1
  mov R1, [BP-141]
  mov [SP+1], R1
  call __function_enqueue
  jmp __if_2604_end
__if_2604_else:
__if_2641_start:
  mov R1, [BP-109]
  iadd R1, 1
  mov R0, [R1]
  mov R2, [BP-110]
  iadd R2, 1
  mov R1, [R2]
  ilt R0, R1
  jf R0, __if_2641_end
  mov R1, [global_robotQueue]
  mov [SP], R1
  mov R1, [BP-107]
  mov [SP+1], R1
  call __function_enqueue
  mov R1, [global_robotQueue]
  mov [SP], R1
  mov R1, [BP-109]
  mov [SP+1], R1
  call __function_enqueue
  mov R1, [global_robotQueue]
  mov [SP], R1
  mov R1, [BP-136]
  mov [SP+1], R1
  call __function_enqueue
  mov R1, [global_robotQueue]
  mov [SP], R1
  mov R1, [BP-137]
  mov [SP+1], R1
  call __function_enqueue
  mov R1, [global_robotQueue]
  mov [SP], R1
  mov R1, [BP-138]
  mov [SP+1], R1
  call __function_enqueue
  mov R1, [global_robotQueue]
  mov [SP], R1
  mov R1, [BP-108]
  mov [SP+1], R1
  call __function_enqueue
  mov R1, [global_robotQueue]
  mov [SP], R1
  mov R1, [BP-110]
  mov [SP+1], R1
  call __function_enqueue
  mov R1, [global_robotQueue]
  mov [SP], R1
  mov R1, [BP-139]
  mov [SP+1], R1
  call __function_enqueue
  mov R1, [global_robotQueue]
  mov [SP], R1
  mov R1, [BP-140]
  mov [SP+1], R1
  call __function_enqueue
  mov R1, [global_robotQueue]
  mov [SP], R1
  mov R1, [BP-141]
  mov [SP+1], R1
  call __function_enqueue
__if_2641_end:
__if_2604_end:
__if_2567_end:
__if_2521_end:
__if_2514_end:
__if_2498_end:
__if_2482_end:
__if_2455_end:
__if_2449_end:
__if_2678_start:
  mov R0, [BP-115]
  jf R0, __if_2678_end
  mov R0, 1
  mov [BP-113], R0
__if_2678_end:
  mov R1, 60
  mov [SP], R1
  call __function_select_region
  mov R1, 1.500000
  mov [SP], R1
  mov R1, 1.500000
  mov [SP+1], R1
  call __function_set_drawing_scale
  mov R1, 290
  mov [SP], R1
  mov R1, 25
  mov [SP+1], R1
  call __function_draw_region_zoomed_at
  mov R1, 290
  mov [SP], R1
  mov R1, 270
  mov [SP+1], R1
  call __function_draw_region_zoomed_at
__if_2695_start:
  mov R0, [BP-111]
  jf R0, __if_2695_end
  mov R1, 340
  mov [SP], R1
  mov R1, 100
  mov [SP+1], R1
  call __function_draw_region_zoomed_at
  mov R1, 390
  mov [SP], R1
  mov R1, 100
  mov [SP+1], R1
  call __function_draw_region_zoomed_at
  mov R1, 440
  mov [SP], R1
  mov R1, 100
  mov [SP+1], R1
  call __function_draw_region_zoomed_at
  mov R1, 340
  mov [SP], R1
  mov R1, 195
  mov [SP+1], R1
  call __function_draw_region_zoomed_at
  mov R1, 390
  mov [SP], R1
  mov R1, 195
  mov [SP+1], R1
  call __function_draw_region_zoomed_at
  mov R1, 440
  mov [SP], R1
  mov R1, 195
  mov [SP+1], R1
  call __function_draw_region_zoomed_at
  mov R2, [BP-109]
  mov R1, [R2]
  mov [SP], R1
  call __function_select_region
  mov R1, 1.500000
  mov [SP], R1
  mov R1, 1.500000
  mov [SP+1], R1
  call __function_set_drawing_scale
  mov R1, 490
  mov [SP], R1
  mov R1, 100
  mov [SP+1], R1
  call __function_draw_region_zoomed_at
  mov R2, [BP-110]
  mov R1, [R2]
  mov [SP], R1
  call __function_select_region
  mov R1, 1.500000
  mov [SP], R1
  mov R1, 1.500000
  mov [SP+1], R1
  call __function_set_drawing_scale
  mov R1, 490
  mov [SP], R1
  mov R1, 195
  mov [SP+1], R1
  call __function_draw_region_zoomed_at
__if_2695_end:
  mov R2, [BP-107]
  mov R1, [R2]
  mov [SP], R1
  call __function_select_region
  mov R1, 1.500000
  mov [SP], R1
  mov R1, 1.500000
  mov [SP+1], R1
  call __function_set_drawing_scale
  mov R1, 290
  mov [SP], R1
  mov R1, 100
  mov [SP+1], R1
  call __function_draw_region_zoomed_at
  mov R2, [BP-108]
  mov R1, [R2]
  mov [SP], R1
  call __function_select_region
  mov R1, 1.500000
  mov [SP], R1
  mov R1, 1.500000
  mov [SP+1], R1
  call __function_set_drawing_scale
  mov R1, 290
  mov [SP], R1
  mov R1, 195
  mov [SP+1], R1
  call __function_draw_region_zoomed_at
__if_2752_start:
  mov R0, [BP-112]
  jf R0, __if_2752_end
  mov R1, 10
  mov [SP], R1
  mov R1, 20
  mov [SP+1], R1
  mov R1, __literal_string_2758
  mov [SP+2], R1
  call __function_print_at
__if_2752_end:
__if_2759_start:
  mov R1, [global_playerQueue]
  iadd R1, 2
  mov R0, [R1]
  ieq R0, 0
  jt R0, __LogicalOr_ShortCircuit_2766
  mov R2, [global_robotQueue]
  iadd R2, 2
  mov R1, [R2]
  ieq R1, 0
  or R0, R1
__LogicalOr_ShortCircuit_2766:
  jf R0, __if_2759_end
__if_2770_start:
  mov R1, [global_playerQueue]
  iadd R1, 2
  mov R0, [R1]
  mov R2, [global_robotQueue]
  iadd R2, 2
  mov R1, [R2]
  igt R0, R1
  jf R0, __if_2770_else
  mov R1, 10
  mov [SP], R1
  mov R1, 20
  mov [SP+1], R1
  mov R1, __literal_string_2780
  mov [SP+2], R1
  call __function_print_at
  jmp __if_2770_end
__if_2770_else:
  mov R1, 10
  mov [SP], R1
  mov R1, 20
  mov [SP+1], R1
  mov R1, __literal_string_2785
  mov [SP+2], R1
  call __function_print_at
__if_2770_end:
__if_2759_end:
  mov R2, [global_playerQueue]
  iadd R2, 2
  mov R1, [R2]
  mov [SP], R1
  lea R1, [BP-125]
  mov [SP+1], R1
  mov R1, 10
  mov [SP+2], R1
  call __function_itoa
  mov R1, 250
  mov [SP], R1
  mov R1, 115
  mov [SP+1], R1
  lea R1, [BP-125]
  mov [SP+2], R1
  call __function_print_at
  mov R1, 30
  mov [SP], R1
  mov R1, 115
  mov [SP+1], R1
  mov R1, __literal_string_2801
  mov [SP+2], R1
  call __function_print_at
  mov R1, 120
  mov [SP], R1
  mov R1, 140
  mov [SP+1], R1
  mov R1, __literal_string_2805
  mov [SP+2], R1
  call __function_print_at
  mov R2, [global_robotQueue]
  iadd R2, 2
  mov R1, [R2]
  mov [SP], R1
  lea R1, [BP-135]
  mov [SP+1], R1
  mov R1, 10
  mov [SP+2], R1
  call __function_itoa
  mov R1, 250
  mov [SP], R1
  mov R1, 210
  mov [SP+1], R1
  lea R1, [BP-135]
  mov [SP+2], R1
  call __function_print_at
  mov R1, 30
  mov [SP], R1
  mov R1, 210
  mov [SP+1], R1
  mov R1, __literal_string_2821
  mov [SP+2], R1
  call __function_print_at
  mov R1, 120
  mov [SP], R1
  mov R1, 235
  mov [SP+1], R1
  mov R1, __literal_string_2825
  mov [SP+2], R1
  call __function_print_at
__if_2826_start:
  mov R0, [BP-113]
  jf R0, __if_2826_end
  mov R2, 123
  mov [SP], R2
  mov R2, 172
  mov [SP+1], R2
  mov R2, 200
  mov [SP+2], R2
  call __function_make_color_rgb
  mov R1, R0
  mov [BP-142], R1
  mov R1, [BP-142]
  mov [SP], R1
  call __function_clear_screen
__if_2826_end:
  call __function_end_frame
  jmp __while_2429_start
__while_2429_end:
__function_main_return:
  mov SP, BP
  pop BP
  ret

__literal_string_1704:
  string "0123456789ABCDEF"
__literal_string_1814:
  string "."
__literal_string_1825:
  string "0"
__literal_string_2758:
  string "Press enter to see cards!"
__literal_string_2780:
  string "PLAYER WINS"
__literal_string_2785:
  string "ROBOT WINS"
__literal_string_2801:
  string "Player cards remaing:"
__literal_string_2805:
  string "Player Card ->"
__literal_string_2821:
  string "Robot cards remaing:"
__literal_string_2825:
  string "Robot Card ->"
