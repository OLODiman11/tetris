class_name TetrisShape

enum Type {
	I_Block, 
	J_Block, 
	L_Block, 
	O_Block, 
	S_Block, 
	T_Block, 
	Z_Block}

var type: Type

var _shape: Array[Array]

func _init(shape_type: Type):
	self.type = shape_type
	match shape_type:
		Type.I_Block:
			_shape = TetrisShape.get_i_block_shape()
		Type.J_Block:
			_shape = TetrisShape.get_j_block_shape()
		Type.L_Block:
			_shape = TetrisShape.get_l_block_shape()
		Type.O_Block:
			_shape = TetrisShape.get_o_block_shape()
		Type.S_Block:
			_shape = TetrisShape.get_s_block_shape()
		Type.T_Block:
			_shape = TetrisShape.get_t_block_shape()
		Type.Z_Block:
			_shape = TetrisShape.get_z_block_shape()
			
func rotate():
	_shape = get_rotation()
	
func get_rotation() -> Array[Array]:
	var n = get_size()
	var rotated_shape: Array[Array] = []
	for i in range(n):
		var line = []
		line.resize(n)
		line.fill(0)
		rotated_shape.append(line)
	
	for row in range(n):
		for col in range(n):
			rotated_shape[col][n-row-1] = _shape[row][col]
			
	return rotated_shape

func get_shape():
	return _shape.duplicate(true)	
	
func get_size():
	return _shape.size()
	
static func get_i_block_shape() -> Array[Array]:
	return [ 
		[0, 1, 0, 0],
		[0, 1, 0, 0],
		[0, 1, 0, 0],
		[0, 1, 0, 0]]
		
static func get_j_block_shape() -> Array[Array]:
	return [ 
		[2, 0, 0],
		[2, 2, 2],
		[0, 0, 0]]
		
static func get_l_block_shape() -> Array[Array]:
	return [ 
		[0, 0, 3],
		[3, 3, 3],
		[0, 0, 0]]
		
static func get_o_block_shape() -> Array[Array]:
	return [ 
		[4, 4],
		[4, 4]]
		
static func get_s_block_shape() -> Array[Array]:
	return [ 
		[0, 0, 0],
		[0, 5, 5],
		[5, 5, 0]]
		
static func get_t_block_shape() -> Array[Array]:
	return [ 
		[0, 6, 0],
		[6, 6, 6],
		[0, 0, 0]]
		
static func get_z_block_shape() -> Array[Array]:
	return [ 
		[0, 0, 0],
		[7, 7, 0],
		[0, 7, 7]]
