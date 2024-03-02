extends Node

func _ready():
	MobileAds.initialize()
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	
