extends Label

func _process(delta):
	set_text("FRS: %s" % Engine.get_frames_per_second())
