class_name GameManager

extends Node

signal game_lost

@export var width := 10
@export var height := 20
@export var tiles_per_sec := 1.0
@export var speed_boost := 2.0
@export var grid_visualuzer: GridVisualizer = null

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
		_grid_manager.clean_up_filled_rows()
		if not try_add_random_shape():
			emit_signal("game_lost")
			_is_running = false
	
	if moved:
		redraw_grid()
	
func restart():
	_is_running = true
	_grid_manager = GridManager.new(width, height)
	try_add_random_shape()
	redraw_grid()
	grid_visualuzer.show()
	
func try_add_random_shape():
	var random_shape_type = TetrisShape.Type.values()[randi_range(0, TetrisShape.Type.size() - 1)]
	return _grid_manager.try_add_new_shape(random_shape_type, -10, width / 2)

func is_running():
	return _is_running
	
func redraw_grid():
	grid_visualuzer.update_grid(_grid_manager.get_whole_grid())
