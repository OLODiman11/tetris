extends Control

const languageCodes = ["en", "ru"]

var index = 0

func _ready():
	$VBoxContainer/StartButton.grab_focus()
	TranslationServer.set_locale(languageCodes[index])
	updateUI()


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_language_button_pressed():
	index = (index + 1) % languageCodes.size()
	TranslationServer.set_locale(languageCodes[index])
	updateUI()


func _on_exit_button_pressed():
	get_tree().quit()

func updateUI():
	$VBoxContainer/StartButton.text = tr("START")
	$VBoxContainer/OptionsButton.text = tr("OPTIONS")
	$LanguageButton.text = tr("LANGUAGE")
	$VBoxContainer/ExitButton.text = tr("EXIT")
	$VBoxContainer/LeaderstatsButton.text = tr("LEADERSTATS")
