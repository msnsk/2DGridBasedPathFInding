extends Control


onready var board: TileMap = get_parent().get_node("Board")
onready var astar: AStar2D = board.astar
onready var offset: Vector2 = board.half_cell_size

	
func _ready():
	_draw()


func _draw():
	for point in astar.get_points():
		if astar.is_point_disabled(point):
			print("astar point is disabled")
			continue
		
		var cell = astar.get_point_position(point)
		var pos = board.map_to_world(cell)
		draw_circle(pos + offset, 4, Color.white)
		
		var point_connections = astar.get_point_connections(point)
		var connected_positions = []
		
		for connected_point in point_connections:
			if astar.is_point_disabled(connected_point):
				print("connected point is disabled")
				continue
			var connected_cell = astar.get_point_position(connected_point)
			var connected_pos = board.map_to_world(connected_cell)
			connected_positions.append(connected_pos)
		
		for connected_pos in connected_positions:
			draw_line(pos + offset, connected_pos + offset, Color.white, 2)
