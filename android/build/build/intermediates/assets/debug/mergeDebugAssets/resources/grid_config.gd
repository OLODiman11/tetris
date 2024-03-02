class_name GridConfig

extends Resource

@export var tile_size := 39.0
@export var tile_margin := 2.0
@export var fall_preview_alpha := 0.5
@export var background_color := Color.DIM_GRAY
@export var colors: PackedColorArray = [
	Color.TRANSPARENT, 
	Color.RED, 
	Color.ORANGE, 
	Color.YELLOW, 
	Color.GREEN, 
	Color.BLUE, 
	Color.DARK_BLUE, 
	Color.PURPLE
	]
	
func _init(tile_size := 39.0, tile_margin := 2.0, background_color := Color.DIM_GRAY, colors: PackedColorArray = [
	Color.TRANSPARENT, 
	Color.RED, 
	Color.ORANGE, 
	Color.YELLOW, 
	Color.GREEN, 
	Color.BLUE, 
	Color.DARK_BLUE, 
	Color.PURPLE
	]):
	self.tile_size = tile_size
	self.tile_margin = tile_margin
	self.background_color = background_color
	self.colors = colors
