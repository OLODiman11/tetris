extends GutTest

var test_add_new_shape_params = [
	[2, 3, [
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 7, 7, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 7, 7, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]], 
	[2, -5, [
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[7, 7, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 7, 7, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]], 
	[2, 20, [
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 7, 7, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 7, 7],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]], 
	[-10, 3, [
	[0, 0, 0, 7, 7, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 7, 7, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]], 
	[20, 3, [
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 7, 7, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 7, 7, 0, 0, 0, 0]]]
]

func test_add_new_shape(params=use_parameters(test_add_new_shape_params)):
	var width = 10
	var height = 10
	var grid_manager = GridManager.new(width, height)
	grid_manager.add_new_shape(TetrisShape.Type.Z_Block, params[0], params[1])
	assert_eq_deep(grid_manager.get_whole_grid(), params[2])

var test_can_fit_params = [
	[true, 0, 0,[
		[1, 0, 1, 1],
		[1, 0, 1, 1],
		[1, 0, 0, 1],
		[1, 1, 1, 1]]],
	[true, 1, 1,[
		[1, 1, 1, 1],
		[1, 1, 0, 1],
		[1, 1, 0, 1],
		[1, 1, 0, 0]]],
	[true, 0, -1,[
		[0, 1, 1, 1],
		[0, 1, 1, 1],
		[0, 0, 1, 1],
		[1, 1, 1, 1]]],
	[false, 1, 2,[
		[0, 0, 0, 0],
		[0, 0, 0, 0],
		[0, 0, 0, 0],
		[0, 0, 0, 0]]],
	[false, 0, 0,[
		[0, 0, 0, 0],
		[0, 1, 0, 0],
		[0, 0, 0, 0],
		[0, 0, 0, 0]]]
]

func test_can_fit(params=use_parameters(test_can_fit_params)):
	var grid_manager = _prepare_grid(4, 4, params, TetrisShape.Type.L_Block)
	var shape: Array[Array] = [
		[0, 1, 0],
		[0, 1, 0],
		[0, 1, 1]]
	var expected: bool = params[0]
	var row: int = params[1]
	var col: int = params[2]
	
	var can_fit = grid_manager.can_fit(shape, row, col)

	assert_eq(can_fit, expected)

var test_try_rotate_shape_params = [
	[true, 0, 0,[
		[0, 1, 1],
		[0, 0, 1],
		[1, 0, 1]]],
	[false, 0, 0,[
		[1, 0, 0],
		[0, 0, 0],
		[0, 0, 0]]],
	[false, -1, 0,[
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0]]]
]

func test_try_rotate_shape(params=use_parameters(test_try_rotate_shape_params)):
	var expected: bool = params[0]
	var grid_manager = _prepare_grid(3, 3, params, TetrisShape.Type.S_Block)
	
	var can_rotate = grid_manager.try_rotate_shape()
	
	assert_eq(can_rotate, expected)
	
var test_try_move_up_params = [
	[true, 0, 0,[
		[1, 0, 0],
		[0, 0, 1],
		[1, 1, 1]]],
	[false, -1, 0,[
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0]]],
	[false, 0, 0,[
		[0, 0, 1],
		[0, 0, 0],
		[0, 0, 0]]]
]

func test_try_move_up(params=use_parameters(test_try_move_up_params)):
	var expected: bool = params[0]
	var grid_manager = _prepare_grid(3, 3, params, TetrisShape.Type.S_Block)
	
	var can_move = grid_manager.try_move_up()
	
	assert_eq(can_move, expected)
	
var test_try_move_down_params = [
	[true, -1, 0,[
		[1, 1, 1],
		[1, 0, 0],
		[0, 0, 1]]],
	[false, 0, 0,[
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0]]],
	[false, -1, 0,[
		[0, 0, 0],
		[0, 0, 0],
		[1, 0, 0]]]
]

func test_try_move_down(params=use_parameters(test_try_move_down_params)):
	var expected: bool = params[0]
	var grid_manager = _prepare_grid(3, 3, params, TetrisShape.Type.S_Block)
	
	var can_move = grid_manager.try_move_down()
	
	assert_eq(can_move, expected)

var test_try_move_right_params = [
	[true, 0, 0,[
		[1, 0, 1, 1],
		[1, 0, 0, 0],
		[1, 1, 1, 1]]],
	[false, 0, 1,[
		[0, 0, 0, 0],
		[0, 0, 0, 0],
		[0, 0, 0, 0]]],
	[false, 0, 0,[
		[0, 1, 0, 0],
		[0, 0, 0, 0],
		[0, 0, 0, 0]]]
]

func test_try_move_right(params=use_parameters(test_try_move_right_params)):
	var expected: bool = params[0]
	var grid_manager = _prepare_grid(4, 3, params, TetrisShape.Type.J_Block)
	
	var can_move = grid_manager.try_move_right()
	
	assert_eq(can_move, expected)
	
var test_try_move_left_params = [
	[true, 0, 1,[
		[0, 1, 1, 1],
		[0, 0, 0, 1],
		[1, 1, 1, 1]]],
	[false, 0, 0,[
		[0, 0, 0, 0],
		[0, 0, 0, 0],
		[0, 0, 0, 0]]],
	[false, 0, 1,[
		[1, 0, 0, 0],
		[0, 0, 0, 0],
		[0, 0, 0, 0]]]
]

func test_try_move_left(params=use_parameters(test_try_move_left_params)):
	var expected: bool = params[0]
	var grid_manager = _prepare_grid(4, 3, params, TetrisShape.Type.J_Block)
	
	var can_move = grid_manager.try_move_left()
	
	assert_eq(can_move, expected)
	
func _prepare_grid(width: int, height: int, params: Array, shape_type: TetrisShape.Type) -> GridManager:
	var expected: bool = params[0]
	var row: int = params[1]
	var col: int = params[2]
	var grid: Array[Array] = _to_Array_of_Array(params[3])
	
	var grid_manager = GridManager.new(width, height)
	grid_manager.add_new_shape(shape_type, row, col)
	grid_manager._grid = grid
	
	return grid_manager
	
func _to_Array_of_Array(array):
	var result: Array[Array] = []
	for row in range(array.size()):
		result.append([])
		for col in range(array[0].size()):
			result[row].append(array[row][col])
	return result
