extends TileMap


var path: Array = []
var cells = get_used_cells()

onready var obstacles = $Obstacles
onready var astar = AStar2D.new()
onready var half_cell_size = cell_size / 2


func _ready():
	randomize()
	add_points()
	connect_points()
	disable_points(get_obstacles())


func add_points():
	for cell in cells:
		astar.add_point(id(cell), cell)


func connect_points():
	for cell in cells:
		if astar.has_point(id(cell)):
			var neighbors = [
				Vector2.RIGHT,
				Vector2.LEFT,
				Vector2.DOWN,
				Vector2.UP
			]
			for neighbor in neighbors:
				var next_cell = cell + neighbor
				if cells.has(next_cell):
					astar.connect_points(id(cell), id(next_cell), false)


func get_obstacles() -> Array:
	var obstacle_cells = []
	for child in obstacles.get_children():
		obstacle_cells.append(world_to_map(child.global_position))
	return obstacle_cells


func disable_points(target_cells):
	for cell in target_cells:
		astar.set_point_disabled(id(cell))


func update_path(start, end):
	path = astar.get_point_path(id(start), id(end))


func id(point):
	var a = point.x
	var b = point.y
	return (a + b) * (a + b + 1) / 2 + b


