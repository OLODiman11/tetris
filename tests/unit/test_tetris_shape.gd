extends GutTest

var test_rotate_params = [
	[TetrisShape.Type.I_Block, 
	[
		[0, 0, 0, 0],
		[1, 1, 1, 1],
		[0, 0, 0, 0],
		[0, 0, 0, 0]],
	[
		[0, 0, 1, 0],
		[0, 0, 1, 0],
		[0, 0, 1, 0],
		[0, 0, 1, 0]],
	[
		[0, 0, 0, 0],
		[0, 0, 0, 0],
		[1, 1, 1, 1],
		[0, 0, 0, 0]],
	],
	[TetrisShape.Type.J_Block, 
	[
		[0, 2, 2],
		[0, 2, 0],
		[0, 2, 0]],
	[
		[0, 0, 0],
		[2, 2, 2],
		[0, 0, 2]],
	[
		[0, 2, 0],
		[0, 2, 0],
		[2, 2, 0]],
	]
	
]

func test_rotate(params=use_parameters(test_rotate_params)):
	var shape = TetrisShape.new(params[0])

	assert_eq_deep(shape.get_rotation(), params[1])
	shape.rotate()
	
	assert_eq_deep(shape.get_rotation(), params[2])
	shape.rotate()
	
	assert_eq_deep(shape.get_rotation(), params[3])
	shape.rotate()
	
var test_get_actual_bounds_params = [
	[TetrisShape.Type.I_Block, Vector4i(1, 0, 1, 3)],
	[TetrisShape.Type.J_Block, Vector4i(0, 0, 2, 1)],
	[TetrisShape.Type.L_Block, Vector4i(0, 0, 2, 1)],
	[TetrisShape.Type.O_Block, Vector4i(0, 0, 1, 1)],
	[TetrisShape.Type.S_Block, Vector4i(0, 1, 2, 2)],
	[TetrisShape.Type.T_Block, Vector4i(0, 0, 2, 1)],
	[TetrisShape.Type.Z_Block, Vector4i(0, 1, 2, 2)]
]
	
func test_get_actual_bounds(params=use_parameters(test_get_actual_bounds_params)):
	var shape = TetrisShape.new(params[0])
	assert_eq(shape.get_actual_bounds(), params[1])
	
