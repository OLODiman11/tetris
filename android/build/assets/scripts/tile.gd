class_name Tile

extends Sprite2D

var TEXTURE := load("res://textures/1x1_white.png")

func _init(color: Color, position: Vector2i, size: Vector2i):
	texture = TEXTURE
	centered = false
	self.position = position
	scale = size
	modulate = color
