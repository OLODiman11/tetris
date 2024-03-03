class_name PreviewBox

extends Node2D

@export var gap: int = 10

func show_preview(types: Array[TetrisShape.Type]):
	for child in get_children():
		remove_child(child)
	
	var y := 0
	for type in types:
		var preview := ShapePreview.new(type)
		var bounds := preview.get_bounds()
		preview.position.x = - bounds[0] - bounds[2] / 2.0
		preview.position.y = y - bounds[1]
		y += bounds[3] + gap
		add_child(preview)
