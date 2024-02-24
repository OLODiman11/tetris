class_name PreviewBox

extends Node2D

@export var gap: int = 10

func show_preview(types: Array[TetrisShape.Type]):
	for child in get_children():
		remove_child(child)
	
	var y := 0
	for type in types:
		var preview := ShapePreview.new(type)
		preview.position.y = y
		y += preview.get_height() + gap
		add_child(preview)
