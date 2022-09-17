extends Node2D


onready var board = $Board
onready var line = $Line
onready var player = $Player


func _input(event):
	if event.is_action_pressed("move_to"):
		var target_cell = board.world_to_map(get_global_mouse_position())
		var target_cell_id = board.id(target_cell)
		if board.astar.has_point(target_cell_id):
			var player_cell = board.world_to_map(player.global_position)
			board.update_path(player_cell, target_cell)
			move()


func move():
	set_process_input(false)
	for point in board.path:
		line.add_point(board.map_to_world(point) + board.half_cell_size)
	
	for point in board.path:
		player.global_position = board.map_to_world(point)
		yield(get_tree().create_timer(0.1), "timeout")
	
	line.clear_points()
	set_process_input(true)
