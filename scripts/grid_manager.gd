class_name GridManager

var current_shape: TetrisShape = null
var s_row: int
var s_col: int
var p_row: int

var _grid: Array[Array]

func _init(width: int, height: int):
	_grid = []
	for i in range(height):
		_grid.append(_get_empty_row(width))
		
func try_add_new_shape(type: TetrisShape.Type, row, col):
	current_shape = TetrisShape.new(type)
	var bounds := current_shape.get_actual_bounds()
	s_col = clamp(col, -bounds[0], get_width() - bounds[2] - 1)
	s_row = clamp(row, -bounds[1], get_height() - bounds[3] - 1)
	if can_fit(current_shape.get_shape(), s_row, s_col):
		get_preview_row()
		return true
	return false
	
func get_preview_row():
	for row in range(s_row + 1, get_height()):
		if not can_fit(current_shape.get_shape(), row, s_col):
			p_row = row - 1
			break
	return p_row
	
func stick_to_grid(shape: Array[Array], row: int, col: int):
	var new_grid = get_grid()
		
	var width := shape[0].size()
	var height := shape.size()
	for c in range(width):
		var out_of_bounds := c + col < 0 || c + col >= get_width()
		if out_of_bounds:
			continue
		for r in range(height):
			if current_shape.get_shape()[r][c] == 0:
				continue
			out_of_bounds = r + row < 0 || r + row >= get_height()
			if out_of_bounds:
				continue
			new_grid[row+r][col+c] = -shape[r][c]
			new_grid[row+r][col+c] = shape[r][c]
	return new_grid
	
func get_whole_grid() -> Array[Array]:
	var whole_grid = get_grid()
	if current_shape == null:
		return whole_grid
		
	var n = current_shape.get_size()
	for col in range(n):
		var out_of_bounds := col + s_col < 0 || col + s_col >= get_width()
		if out_of_bounds:
			continue
		for row in range(n):
			if current_shape.get_shape()[row][col] == 0:
				continue
			out_of_bounds = row + s_row < 0 || row + s_row >= get_height()
			if out_of_bounds:
				continue
			whole_grid[row+p_row][col+s_col] = -current_shape.get_shape()[row][col]
			whole_grid[row+s_row][col+s_col] = current_shape.get_shape()[row][col]
	return whole_grid
	
func can_fit(shape: Array[Array], row: int, col: int) -> bool:
	var h = shape.size()
	var w = shape[0].size()
	
	for c in range(w):
		for r in range(h):
			var shape_occupied = shape[r][c] != 0
			if not shape_occupied:
				continue
				
			var out_of_height = row+r < 0 || row+r >= get_height()
			var out_of_width = col+c < 0 || col+c >= get_width()
			if out_of_width || out_of_height:
				return false
			
			var grid_occupied = _grid[row+r][col+c] != 0
			if grid_occupied:
				return false
				
	return true
	
func can_rotate_shape() -> bool:
	return can_fit(current_shape.get_rotation(), s_row, s_col)
	
func try_rotate_shape() -> bool:
	if can_rotate_shape():
		current_shape.rotate()
		get_preview_row()
		return true
	return false
	
func can_move_up() -> bool:
	return can_fit(current_shape.get_shape(), s_row - 1, s_col)
	
func try_move_up() -> bool:
	if can_move_up():
		s_row -= 1
		return true
	return false
	
func can_move_down() -> bool:
	return can_fit(current_shape.get_shape(), s_row + 1, s_col)
	
func try_move_down() -> bool:
	if can_move_down():
		s_row += 1
		return true
	return false
	
func can_move_left() -> bool:
	return can_fit(current_shape.get_shape(), s_row, s_col - 1)
	
func try_move_left() -> bool:
	if can_move_left():
		s_col -= 1
		get_preview_row()
		return true
	return false
	
func can_move_right() -> bool:
	return can_fit(current_shape.get_shape(), s_row, s_col + 1)
	
func try_move_right() -> bool:
	if can_move_right():
		s_col += 1
		get_preview_row()
		return true
	return false
	
func stick_shape_to_grid():
	_grid = stick_to_grid(current_shape.get_shape(), s_row, s_col)
	current_shape = null
	
func clean_up_filled_rows():
	var filled_rows = get_filled_rows()
	var new_grid: Array[Array] = []
	
	
	for i in range(filled_rows.size()):
		new_grid.append(_get_empty_row(get_width()))
	
	for row in range(get_height()):
		if row not in filled_rows:
			new_grid.append(_grid[row])
			
	
	_grid = new_grid
	
func get_filled_rows() -> Array[int]:
	var filled_rows: Array[int] = []
	for row in range(get_height()):
		if row_is_filled(row):
			filled_rows.append(row)
	return filled_rows
				
func row_is_filled(row: int) -> bool:
	for col in range(get_width()):
		if _grid[row][col] == 0:
			return false
	return true
	
func get_width() -> int:
	return _grid[0].size()

func get_height() -> int:
	return _grid.size()
	
func get_grid() -> Array[Array]:
	return _grid.duplicate(true)

func _get_empty_row(width: int) -> Array[int]:
	var row: Array[int] = []
	row.resize(width)
	row.fill(0)
	return row
