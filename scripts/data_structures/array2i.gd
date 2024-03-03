class_name Array2i

var _items: Array[PackedInt32Array]

func _init(width: int, height: int):
	_items = []
	for row in range(height):
		var empty_row := PackedInt32Array()
		empty_row.resize(width)
		empty_row.fill(0)
		_items.append(empty_row)
		
func eq(other: Array2i) -> bool:
	if self.width() != other.width():
		return false
	if self.height() != other.height():
		return false
	for row in range(height()):
		for col in range(width()):
			if self.get_item(row, col) != other.get_item(row, col):
				return false
	return true
		
func get_item(row: int, col: int) -> int:
	return _items[row][col]
	
func set_item(row: int, col: int, value: int):
	_items[row][col] = value
	
func width() -> int:
	return _items[0].size()
	
func height() -> int:
	return _items.size()
	
func _to_string() -> String:
	var formated_rows: PackedStringArray = []
	for row in _items:
		var str_array := PackedStringArray(Array(row))
		var formated_row = ' '.join(str_array)
		formated_rows.append(formated_row)
	return '\n'.join(formated_rows)
	
