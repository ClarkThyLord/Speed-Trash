extends Spatial



## Exported Variables
export(int, 0, 100) var map_objects_max := 5

export(float, 0.0, 10.0) var map_objects_spawn := 1.5



## OnReady Variables
onready var road_animation : AnimationPlayer = get_node("Road/AnimationPlayer")

onready var map_objects : Spatial = get_node("MapObjects")



## Private Variables
var _spawn_time := 0.0

var _spawn_points := [
	Vector3(-5.5, 0, -50),
	Vector3(-1.75, 0, -50),
	Vector3(1.75, 0, -50),
	Vector3(5.5, 0, -50),
]

var _map_objects := [
	preload("res://src/map/objects/trash/trash.tscn")
]



## Built-In Virtual Methods
func _ready() -> void:
	road_animation.play("moving")
	
	randomize()


func _process(delta : float):
	if map_objects.get_child_count() < map_objects_max and _spawn_time >= map_objects_spawn:
		var map_object = _map_objects[randi() % _map_objects.size()].instance()
		map_object.random()
		map_object.translation = _spawn_points[randi() % _spawn_points.size()]
		map_objects.add_child(map_object)
		
		_spawn_time = 0.0
	
	for map_object in map_objects.get_children():
		map_object.translation += Vector3(0, 0, 30 * map_object.speed * delta)
		if map_object.translation.z > 0:
			map_object.random()
			map_object.translation = _spawn_points[randi() % _spawn_points.size()]
	
	_spawn_time += delta 
