extends Spatial

export var max_obstacles := 5
export var max_goals := 5

## OnReady Variables
onready var road_animation : AnimationPlayer = get_node("Road/AnimationPlayer")

#onready var object : Spatial = get_node("Objects")
#onready var obstacle : Spatial = get_node("Objects/Obstacle")
#onready var goal : Spatial = get_node("Objects/Goal")

#onready var obstacle = preload("res://src/obstacles/obstacle.tscn")
#onready var goal = preload("res://src/goals/goal.tscn")

const obstacle = preload("res://src/obstacles/obstacle.tscn")
const goal = preload("res://src/goals/goal.tscn")

var objects = [
	obstacle.instance(),
	obstacle.instance(),
	goal.instance(),
	goal.instance(),
]

## Built-In Virtual Methods
func _ready() -> void:
	randomize()
	road_animation.play("moving")
	_on_Timer_timeout()	
	
func spawn_objects():
	randomize()
	var i = randi() % objects.size()
	var scene = objects[i]
	add_child(scene)


func _on_Timer_timeout():
	spawn_objects()
