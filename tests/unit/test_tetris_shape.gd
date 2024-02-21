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
		[0, 1, 1],
		[0, 1, 0],
		[0, 1, 0]],
	[
		[0, 0, 0],
		[1, 1, 1],
		[0, 0, 1]],
	[
		[0, 1, 0],
		[0, 1, 0],
		[1, 1, 0]],
	]
	
]

func test_rotate(params=use_parameters(test_rotate_params)):
	var shape = TetrisShape.new(params[0])
	shape.rotate()
	assert_eq_deep(shape.get_shape(), params[1])
	
	shape.rotate()
	assert_eq_deep(shape.get_shape(), params[2])
	
	shape.rotate()
	assert_eq_deep(shape.get_shape(), params[3])
