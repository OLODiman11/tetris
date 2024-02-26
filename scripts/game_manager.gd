class_name GameManager

extends Node

signal score_changed(int)
signal game_started
signal game_lost
signal new_shape_placed(Array)

@export var width := 10
@export var height := 22
@export var tiles_per_sec := 2.0
@export var speed_boost := 10.0
@export var scores_per_row := 100
@export var grid_visualuzer: GridVisualizer = null
@export var fast_move_delay := 0.15
@export var side_move_speed := 7

var shape_list: Array[TetrisShape.Type]
var score: int = 0:
	set(value):
		score = value
		emit_signal("score_changed", score)

var _is_running := false
var _grid_manager: GridManager = null
var _time_elapsed := 0.0
var _input_time_elapsed := -fast_move_delay

func _input(event):
	if event.is_action_pressed("restart"):
		restart()
	
	if not is_running():
		return
	
	var should_redraw := false	
	if event.is_action_pressed("rotate"):
		should_redraw = should_redraw || _grid_manager.try_rotate_shape() 
	
	if event.is_action_pressed("move_right"):
		should_redraw = should_redraw || _grid_manager.try_move_right()
		_input_time_elapsed = -fast_move_delay
		
	
	if event.is_action_pressed("move_left"):
		should_redraw = should_redraw || _grid_manager.try_move_left()
		_input_time_elapsed = -fast_move_delay

	if should_redraw:
		redraw_grid()
		
func _process(delta):
	if not is_running():
		return
	
	var moved := false
	
	var sec_per_side_move = 1.0 / side_move_speed
	_input_time_elapsed += delta
	if _input_time_elapsed >= sec_per_side_move:
		_input_time_elapsed = fmod(_input_time_elapsed, sec_per_side_move)
		if Input.is_action_pressed("move_right"):
			moved = moved || _grid_manager.try_move_right() 
		if Input.is_action_pressed("move_left"):
			moved = moved || _grid_manager.try_move_left()
	
	var sec_per_move := 1.0 / tiles_per_sec
	if Input.is_action_pressed("boost"):
		sec_per_move /= speed_boost
		
	if Input.is_action_just_pressed("boost"):
		AudioManager.boost_sfx.play()
		
	if Input.is_action_just_released("boost"):
		AudioManager.boost_sfx.stop()
	
	_time_elapsed += delta
	if _time_elapsed >= sec_per_move:
		_time_elapsed = fmod(_time_elapsed, sec_per_move)
		moved = _grid_manager.try_move_down() || moved
		if not _grid_manager.can_move_down():
			_grid_manager.stick_shape_to_grid()
			var filled_rows = _grid_manager.get_filled_rows()
			score += filled_rows.size() * scores_per_row
			_grid_manager.clean_up_filled_rows()
			
			if not try_place_next_shape():
				emit_signal("game_lost")
				_is_running = false
				AudioManager.background_music.stop()
	
	if moved:
		redraw_grid()
		
	if Input.is_action_pressed("key_exit"):
		get_tree().quit()
	
func restart():
	emit_signal("game_started")
	score = 0
	_is_running = true
	_grid_manager = GridManager.new(width, height)
	populate_shape_list(3)
	try_place_next_shape()
	redraw_grid()
	grid_visualuzer.show()
	AudioManager.background_music.play()
	
	
func populate_shape_list(size: int):
	shape_list = []
	for i in range(size):
		shape_list.append(get_random_shape_type())
	
func pop_next_shape_type() -> TetrisShape.Type:
	var result = shape_list[0]
	shape_list.remove_at(0)
	shape_list.append(get_random_shape_type())
	return result
	
func get_random_shape_type():
	return TetrisShape.Type.values()[randi_range(0, TetrisShape.Type.size() - 1)]

func try_place_next_shape():
	var s_type := pop_next_shape_type()
	emit_signal("new_shape_placed", shape_list)
	return _grid_manager.try_add_new_shape(s_type, -10, width / 2)

func is_running():
	return _is_running
	
func redraw_grid():
	grid_visualuzer.update_grid(_grid_manager.get_whole_grid())
