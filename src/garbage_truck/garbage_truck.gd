extends Area
## Garbage Truck



## Exported Variables
export var speed := 10.0

export(float, 0.0, 1.0) var deceleration := 0.25

export(float, 0.0, 1.0) var acceleration := 0.25

export(float, 0.0, 100.0) var boost_usage := 1.0

export(float, 0.0, 100.0) var break_usage := 1.0

export(float, 0.0, 100.0) var momentum := 0.0

export(float, 0.0, 100.0) var momentum_growth := 10.0



## Private Variables
var _breaking := false

var _boosting := false



## OnReady Variables
onready var animation_player : AnimationPlayer = get_node("AnimationPlayer")



## Built-In Virtual Methods
func _process(delta):
	var direction := Vector3.ZERO
	if Input.is_action_pressed("ui_right") and translation.x < 6:
		direction += Vector3.RIGHT
	if Input.is_action_pressed("ui_left") and translation.x > -6:
		direction += Vector3.LEFT
	
	_breaking = Input.is_action_pressed("action_break") and momentum >= break_usage
	if _breaking:
		direction -= direction * deceleration
	
	_boosting = Input.is_action_pressed("action_accelerate") and momentum >= boost_usage
	if _boosting:
		direction += direction * acceleration
	
	translate(direction * speed * delta)
	
	momentum += momentum_growth * delta



## Public Methods
func is_boosting() -> bool:
	return _boosting


func is_breaking() -> bool:
	return _breaking


func _on_GargabeTruck_area_entered(area : Area):
	if area.is_in_group("obstacles") and not animation_player.is_playing():
		animation_player.play("hit")
