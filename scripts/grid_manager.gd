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
	s_row = clamp(row, 0, get_height() - current_shape.get_size())
	s_col = clamp(col, 0, get_width() - current_shape.get_size())
	
	if row < 0:
		while try_move_up():
			pass
	if row >= get_height():
		while try_move_down():
			pass
	if col < 0:
		while try_move_left():
			pass
	if col >= get_width():
		while try_move_right():
			pass
	
func get_whole_grid() -> Array[Array]:
	var whole_grid = get_grid()
	if current_shape == null:
		return whole_grid
	var n = current_shape.get_size()
	for col in range(n):
		for row in range(n):
			whole_grid[row+s_row][col+s_col] = current_shape.get_shape()[row][col]
	return whole_grid
	
func can_fit(shape: Array[Array], row: int, col: int) -> bool:
	var h = shape.size()
	var w = shape[0].size()
	
	for c in range(w):
		for r in range(h):
			var shape_occupied = shape[r][c] == 1
			if not shape_occupied:
				continue
				
			var out_of_height = row+r < 0 || row+r >= get_height()
			var out_of_width = col+c < 0 || col+c >= get_width()
			if out_of_width || out_of_height:
				return false
			
			var grid_occupied = _grid[row+r][col+c] == 1
			if grid_occupied:
				return false
				
	return true
	
func try_rotate_shape() -> bool:
	if can_fit(current_shape.get_rotation(), s_row, s_col):
		current_shape.rotate()
		return true
	return false
	
func try_move_up() -> bool:
	if can_fit(current_shape.get_shape(), s_row - 1, s_col):
		s_row -= 1
		return true
	return false
	
func try_move_down() -> bool:
	if can_fit(current_shape.get_shape(), s_row + 1, s_col):
		s_row += 1
		return true
	return false
	
func try_move_left() -> bool:
	if can_fit(current_shape.get_shape(), s_row, s_col - 1):
		s_col -= 1
		return true
	return false
	
func try_move_right() -> bool:
	if can_fit(current_shape.get_shape(), s_row, s_col + 1):
		s_col += 1
		return true
	return false
	
func get_width() -> int:
	return _grid[0].size()

func get_height() -> int:
	return _grid.size()
	
func get_grid() -> Array[Array]:
	return _grid.duplicate(true)
