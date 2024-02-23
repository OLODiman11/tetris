@tool

class_name GridVisualizer

extends Node2D

@export var tile_size := 100.0:
	set(value):
		tile_size = value
		update_grid(grid)
@export var tile_margin := 2.0:
	set(value):
		tile_margin = value
		update_grid(grid)
@export var grid: Array[Array] = [
	[0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0]
]:
	set(value):
		grid = value
		update_grid(grid)
@export var colors: Array[Color] = [
	Color.SLATE_GRAY, Color.RED, Color.ORANGE, Color.YELLOW, Color.GREEN, Color.BLUE, Color.DARK_BLUE, Color.PURPLE]:
	set(value):
		colors = value
		update_grid(grid)
	
func _ready():
	if not Engine.is_editor_hint():
		hide()
	
func update_grid(new_grid: Array[Array]):
	var height := new_grid.size()
	var width := new_grid[0].size()
	if get_children().size() - 1 != height * width:
		create_grid(width, height)
	var size := tile_size - 2 * tile_margin
	var children = get_children()
	var tiles: Array[Tile] = []
	for i in range(1, children.size()):
		tiles.append(children[i])
	
	var background: Sprite2D = get_child(0)
	background.modulate = colors[0]
	background.scale = tile_size * Vector2i(width, height)
	
	for row in range(height):
		for col in range(width):
			var color := colors[new_grid[row][col]]
			var index = row * width + col
			var x := col * tile_size + tile_margin
			var y := row * tile_size + tile_margin
			tiles[index].modulate = color
			tiles[index].position = Vector2i(x, y)
			tiles[index].scale = Vector2i(size, size)
			
func create_grid(width: int, height: int):
	var children := get_children()
	for child in children:
		remove_child(child)
		
	var background = Tile.new(colors[0], Vector2i.ZERO, Vector2i.ONE)
	add_child(background)
	
	for row in range(height):
		for col in range(width):
			var tile := Tile.new(colors[0], Vector2i.ZERO, Vector2i.ONE)
			add_child(tile)
