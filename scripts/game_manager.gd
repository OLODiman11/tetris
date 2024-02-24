class_name GameManager

extends Node

signal score_changed(int)
signal game_started
signal game_lost
signal new_shape_placed(Array)

@export var width := 10
@export var height := 22
@export var tiles_per_sec := 1.0
@export var speed_boost := 2.0
@export var scores_per_row := 100
@export var grid_visualuzer: GridVisualizer = null

var shape_list: Array[TetrisShape.Type]
var score: int = 0:
	set(value):
		score = value
		emit_signal("score_changed", score)

var _is_running := false
var _grid_manager: GridManager = null
var _time_elapsed := 0.0


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
	
	if event.is_action_pressed("move_left"):
		should_redraw = should_redraw || _grid_manager.try_move_left()

	if should_redraw:
		redraw_grid()
		
func _process(delta):
	if not is_running():
		return
	
	var sec_per_move := 1.0 / tiles_per_sec
	if Input.is_action_pressed("boost"):
		sec_per_move /= speed_boost
	
	_time_elapsed += delta
	if _time_elapsed < sec_per_move:
		return
		
	_time_elapsed = fmod(_time_elapsed, sec_per_move)
	var moved := _grid_manager.try_move_down()
	if not _grid_manager.can_move_down():
		_grid_manager.stick_shape_to_grid()
		var filled_rows = _grid_manager.get_filled_rows()
		score += filled_rows.size() * scores_per_row
		_grid_manager.clean_up_filled_rows()
		if not try_place_next_shape():
			emit_signal("game_lost")
			_is_running = false
	
	if moved:
		redraw_grid()
	
func restart():
	emit_signal("game_started")
	score = 0
	_is_running = true
	_grid_manager = GridManager.new(width, height)
	populate_shape_list(3)
	try_place_next_shape()
	redraw_grid()
	grid_visualuzer.show()
	
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
