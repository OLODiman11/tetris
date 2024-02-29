extends Control

var languageNames = ["English", "Russian"]
var languageCodes = ["en", "ru"]

var state = "en"

func _ready():
	$VBoxContainer/StartButton.grab_focus()
	TranslationServer.set_locale("en")
	updateUI()


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_language_button_pressed():
	if state == "en":
		TranslationServer.set_locale("ru")
		updateUI()
		state = "ru"
	elif state == "ru":
		TranslationServer.set_locale("en")
		updateUI()
		state = "en"
		

func _on_exit_button_pressed():
	get_tree().quit()

func updateUI():
	$VBoxContainer/StartButton.text = tr("START")
	$VBoxContainer/OptionsButton.text = tr("OPTIONS")
	$LanguageButton.text = tr("LANGUAGE")
	$VBoxContainer/ExitButton.text = tr("EXIT")
	$VBoxContainer/LeaderstatsButton.text = tr("LEADERSTATS")
	


