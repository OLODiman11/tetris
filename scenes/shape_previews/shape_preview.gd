class_name ShapePreview

extends Node2D

@export var config: GridConfig = preload("res://resources/grid_config.tres")
@export var type: TetrisShape.Type
		
var offset: Vector2
var top_left_position: Vector2:
	set(value):
		position = value + offset
	get:
		return position - offset

func _init(type: TetrisShape.Type):
	self.type = type
	update_shape()
	
func _ready():
	update_shape()

func tween_top_left_position(pos: Vector2):
	var tween = create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, 'top_left_position:x', pos.x, 0.5)
	top_left_position.y = pos.y

func set_rotation_state(state: int):
	set_rotation_degrees(90 * state)

func tween_rotation_state(state: int):
	var new_rotation = rotate_toward(rotation, PI / 2.0 * state, 2 * PI)
	var tween = create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, 'rotation', new_rotation, 0.7)

func get_bounds() -> Vector4:
	var bounds := config.tile_size * TetrisShape.new(type).get_actual_bounds()
	return Vector4(bounds[0], bounds[1], 
		bounds[2] - bounds[0] + config.tile_size, 
		bounds[3] - bounds[1] + config.tile_size)

func update_shape():
	for child in get_children():
		remove_child(child)
	var shape = TetrisShape.new(type).get_shape()
	var shape_size = shape.size()
	offset = config.tile_size * shape_size / 2.0 * Vector2.ONE
	var size := config.tile_size - 2 * config.tile_margin
	for row in range(shape_size):
		for col in range(shape_size):
			var color = config.colors[shape[row][col]]
			var pos := config.tile_size * Vector2(col, row) + config.tile_margin * Vector2.ONE - offset
			add_child(Tile.new(color, pos, Vector2(size, size)))
