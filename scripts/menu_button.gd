extends Button

class_name MyButton

func _ready():
	$".".focus_entered.connect(play_focus_sound)
	$".".mouse_entered.connect(play_hover_sound)
	$".".pressed.connect(play_press_sound)



func play_focus_sound():
	AudioManager.button_focus_sfx.play()
	
func play_hover_sound():
	AudioManager.button_hover_sfx.play()
	
func play_press_sound():
	AudioManager.button_press_sfx.play()
