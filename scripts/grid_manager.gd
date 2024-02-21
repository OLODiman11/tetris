class_name GridManager

var current_shape: TetrisShape = null
var s_row: int
var s_col: int

var _grid: Array[Array]

func _init(width: int, height: int):
	_grid = []
	for i in range(height):
		var row = []
		row.resize(width)
		row.fill(0)
		_grid.append(row)
		
func add_new_shape(type: TetrisShape.Type, row, col):
	_grid = get_whole_grid()
	current_shape = TetrisShape.new(type)
	s_row = row
	s_col = col
	
func get_whole_grid() -> Array[Array]:
	var whole_grid = get_grid()
	if current_shape == null:
		return whole_grid
	var n = current_shape.get_size()
	for col in range(n):
		for row in range(n):
			whole_grid[row+s_row][col+s_col] = current_shape.get_shape()[row][col]
	return whole_grid
	
func try_rotate_shape() -> bool:
	var rotated_shape = current_shape.get_rotation()
	var n = current_shape.get_size()
	var can_rotate = true
	for col in range(n):
		for row in range(n):
			var cell_empty = _grid[row+s_row][col+s_col] == 0
			var s_cell_empty = rotated_shape[row][col] == 0
			if cell_empty || s_cell_empty:
				continue
			can_rotate = false
			break
	if can_rotate:
		current_shape.rotate()
	return can_rotate
	
func try_move_down() -> bool:
	var n = current_shape.get_size()
	var shape = current_shape.get_shape()
	var can_move_down = true
	for i in range(n):
		var cell_empty = _grid[s_row+n][s_col+i] == 0
		var s_cell_empty = shape[n-1][i] == 0
		if cell_empty || s_cell_empty:
			continue
		can_move_down = false
		break
	if can_move_down:
		s_row += 1
	return can_move_down
	
func try_move_left() -> bool:
	var n = current_shape.get_size()
	var shape = current_shape.get_shape()
	var can_move_left = true
	for i in range(n):
		var cell_empty = _grid[s_row + i][s_col-1] == 0
		var s_cell_empty = shape[i][0] == 0
		if cell_empty || s_cell_empty:
			continue
		can_move_left = false
		break
	if can_move_left:
		s_col -= 1
	return can_move_left
	
func try_move_right() -> bool:
	var n = current_shape.get_size()
	var shape = current_shape.get_shape()
	var try_move_right = true
	for i in range(n):
		var cell_empty = _grid[s_row+i][s_col+n] == 0
		var s_cell_empty = shape[i][n-1] == 0
		if cell_empty || s_cell_empty:
			continue
		try_move_right = false
		break
	if try_move_right:
		s_col += 1
	return try_move_right
	
func get_width() -> int:
	return _grid[0].size()

func get_height() -> int:
	return _grid.size()
	
func get_grid() -> Array[Array]:
	return _grid.duplicate(true)
