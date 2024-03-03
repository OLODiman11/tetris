class_name GridVisualizer

extends Node2D

@export var config: GridConfig = preload("res://resources/grid_config.tres")

var current_shape: ShapePreview
var fall_preview: ShapePreview

func set_current_shape_rotation(rotation_state: int):
	current_shape.tween_rotation_state(rotation_state)
	
func set_fall_preview_rotation(rotation_state: int):
	fall_preview.set_rotation_state(rotation_state)
	
func set_current_shape(type: TetrisShape.Type, row: int, col: int):
	if current_shape:
		remove_child(current_shape)
	current_shape = ShapePreview.new(type)
	current_shape.update_shape()
	current_shape.top_left_position = config.tile_size * Vector2(col, row)
	add_child(current_shape)
	
	if fall_preview:
		remove_child(fall_preview)
	fall_preview = ShapePreview.new(type)
	var color := Color.WHITE
	color.a = config.fall_preview_alpha
	fall_preview.modulate = color
	fall_preview.update_shape()
	add_child(fall_preview)
	
func set_current_shape_position(row: int, col: int):
	current_shape.top_left_position = config.tile_size * Vector2(col, row)
	
func tween_current_shape_position(row: int, col: int):
	current_shape.tween_top_left_position(config.tile_size * Vector2(col, row))
	
func set_fall_preview_position(row: int, col: int):
	fall_preview.top_left_position = config.tile_size * Vector2(col, row)
	
func update_grid(new_grid: Array[Array]):
	var height := new_grid.size()
	var width := new_grid[0].size()
	if get_children().size() - 1 != height * width:
		create_grid(width, height)
	var size: float = config.tile_size - 2 * config.tile_margin
	var children = get_children()
	var tiles: Array[Tile] = []
	for i in range(1, children.size()):
		tiles.append(children[i])
	
	var background: Sprite2D = get_child(0)
	background.modulate = config.background_color
	background.scale = config.tile_size * Vector2(width, height)
	
	for row in range(height):
		for col in range(width):
			var color: Color = config.colors[abs(new_grid[row][col])]
			if new_grid[row][col] < 0:
				color.a = config.fall_preview_alpha
			var index = row * width + col
			var x: float = col * config.tile_size + config.tile_margin
			var y: float = row * config.tile_size + config.tile_margin
			tiles[index].modulate = color
			tiles[index].position = Vector2(x, y)
			tiles[index].scale = Vector2(size, size)
			
func create_grid(width: int, height: int):
	var children := get_children()
	for child in children:
		remove_child(child)
		
	var background = Tile.new(config.colors[0], Vector2i.ZERO, Vector2i.ONE)
	add_child(background)
	
	for row in range(height):
		for col in range(width):
			var tile := Tile.new(config.colors[0], Vector2i.ZERO, Vector2i.ONE)
			add_child(tile)
