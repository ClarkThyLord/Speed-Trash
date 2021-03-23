extends Spatial



## OnReady Variables
onready var road_animation : AnimationPlayer = get_node("Road/AnimationPlayer")



## Built-In Virtual Methods
func _ready() -> void:
	randomize()
	road_animation.play("moving")
