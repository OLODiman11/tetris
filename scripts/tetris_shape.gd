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

func _init(type: Type):
	self.type = type
	match type:
		Type.I_Block:
			_shape = get_i_block_shape()
		Type.J_Block:
			_shape = get_j_block_shape()
		Type.L_Block:
			_shape = get_l_block_shape()
		Type.O_Block:
			_shape = get_o_block_shape()
		Type.S_Block:
			_shape = get_s_block_shape()
		Type.T_Block:
			_shape = get_t_block_shape()
		Type.Z_Block:
			_shape = get_z_block_shape()
			
func rotate():
	var n = _shape.size()
	var rotated_shape: Array[Array] = []
	for i in range(n):
		var line = []
		line.resize(n)
		line.fill(0)
		rotated_shape.append(line)
	
	for row in range(n):
		for col in range(n):
			rotated_shape[col][n-row-1] = _shape[row][col]
	
	_shape = rotated_shape

func get_shape():
	return _shape	
	
static func get_i_block_shape() -> Array[Array]:
	return [ 
		[0, 1, 0, 0],
		[0, 1, 0, 0],
		[0, 1, 0, 0],
		[0, 1, 0, 0]]
		
static func get_j_block_shape() -> Array[Array]:
	return [ 
		[1, 0, 0],
		[1, 1, 1],
		[0, 0, 0]]
		
static func get_l_block_shape() -> Array[Array]:
	return [ 
		[0, 0, 1],
		[1, 1, 1],
		[0, 0, 0]]
		
static func get_o_block_shape() -> Array[Array]:
	return [ 
		[1, 1],
		[1, 1]]
		
static func get_s_block_shape() -> Array[Array]:
	return [ 
		[0, 0, 0],
		[0, 1, 1],
		[1, 1, 0]]
		
static func get_t_block_shape() -> Array[Array]:
	return [ 
		[0, 1, 0],
		[1, 1, 1],
		[0, 0, 0]]
		
static func get_z_block_shape() -> Array[Array]:
	return [ 
		[0, 0, 0],
		[1, 1, 0],
		[0, 1, 1]]
