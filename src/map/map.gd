extends Spatial



## Exported Variables
export(float, 0.0, 100.0) var road_speed := 30

export(int, 0, 100) var map_objects_max := 10

export(float, 0.0, 10.0) var map_objects_spawn := 1.5



## OnReady Variables
onready var road_animation : AnimationPlayer = get_node("Road/AnimationPlayer")

onready var gargabe_truck := get_node("GargabeTruck")

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
	preload("res://src/map/objects/trash/trash.tscn"),
	preload("res://src/map/objects/vehicle/vehicle.tscn"),
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
	
	var road_velocity := Vector3(0, 0, road_speed)
	if gargabe_truck.is_breaking():
		road_velocity -= road_velocity * gargabe_truck.deceleration
	
	if gargabe_truck.is_boosting():
		road_velocity += road_velocity * gargabe_truck.acceleration
	
	for map_object in map_objects.get_children():
		map_object.translation += road_velocity * map_object.speed * delta
		
		if map_object.translation.z > 0:
			map_object.random()
			map_object.translation = _spawn_points[randi() % _spawn_points.size()]
	
	_spawn_time += delta 
