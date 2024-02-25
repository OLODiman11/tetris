class_name GridVisualizer

extends Node2D

@export var config: GridConfig = preload("res://resources/grid_config.tres")
	
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
	background.scale = config.tile_size * Vector2i(width, height)
	
	for row in range(height):
		for col in range(width):
			var color: Color = config.colors[abs(new_grid[row][col])]
			if new_grid[row][col] < 0:
				color.a = config.fall_preview_alpha
			var index = row * width + col
			var x: float = col * config.tile_size + config.tile_margin
			var y: float = row * config.tile_size + config.tile_margin
			tiles[index].modulate = color
			tiles[index].position = Vector2i(x, y)
			tiles[index].scale = Vector2i(size, size)
			
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
