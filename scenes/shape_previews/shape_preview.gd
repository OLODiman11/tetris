@tool

class_name ShapePreview

extends Node2D

@export var tile_size: int = 39
@export var tile_margin: int = 2
@export var type: TetrisShape.Type:
	set(value):
		type = value
		update_shape()

@export var colors: Array[Color] = [
	Color.TRANSPARENT, Color.RED, Color.ORANGE, Color.YELLOW, Color.GREEN, Color.BLUE, Color.DARK_BLUE, Color.PURPLE]

func _init(type: TetrisShape.Type):
	self.type = type
	update_shape()

func _ready():
	update_shape()

func get_height() -> int:
	return tile_size * TetrisShape.new(type).get_size()

func update_shape():
	for child in get_children():
		remove_child(child)
	var shape = TetrisShape.new(type).get_shape()
	var shape_size = shape.size()
	var size = tile_size - 2 * tile_margin
	for row in range(shape_size):
		for col in range(shape_size):
			var color = colors[shape[row][col]]
			var x = col * tile_size + tile_margin
			var y = row * tile_size + tile_margin
			add_child(Tile.new(color, Vector2i(x, y), Vector2i(size, size)))
