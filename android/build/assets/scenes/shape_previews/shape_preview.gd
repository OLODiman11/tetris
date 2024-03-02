class_name ShapePreview

extends Node2D

@export var config: GridConfig = preload("res://resources/grid_config.tres")
@export var type: TetrisShape.Type

func _init(type: TetrisShape.Type):
	self.type = type
	update_shape()

func _ready():
	update_shape()

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
	var size := config.tile_size - 2 * config.tile_margin
	for row in range(shape_size):
		for col in range(shape_size):
			var color = config.colors[shape[row][col]]
			var x = col * config.tile_size + config.tile_margin
			var y = row * config.tile_size + config.tile_margin
			add_child(Tile.new(color, Vector2i(x, y), Vector2i(size, size)))
