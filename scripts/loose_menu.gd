extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$HBoxContainer/RestartButton.grab_focus()
	updateUI()


func updateUI():
	$HBoxContainer/ExitButton.text = tr("EXIT")
	$HBoxContainer/RestartButton.text = tr("RESTART")
	$Text.text = tr("LOOSE")

func _on_restart_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_exit_button_pressed():
	get_tree().quit()


