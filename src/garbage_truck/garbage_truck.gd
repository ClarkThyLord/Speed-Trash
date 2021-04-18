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

export var ai := false



## Private Variables
var _breaking := false

var _boosting := false



## OnReady Variables
onready var animation_player : AnimationPlayer = get_node("AnimationPlayer")

onready var ray_front : RayCast = get_node("RayFront")

onready var ray_right : RayCast = get_node("RayRight")

onready var ray_right_most : RayCast = get_node("RayRightMost")

onready var ray_left : RayCast = get_node("RayLeft")

onready var ray_left_most : RayCast = get_node("RayLeftMost")



## Built-In Virtual Methods
func _process(delta):
	if ai:
		print(
				ray_front.is_colliding(),
				ray_right.is_colliding(),
				ray_right_most.is_colliding(),
				ray_left.is_colliding(),
				ray_left_most.is_colliding())
	else:
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



## Private Methods
func _on_GargabeTruck_area_entered(area : Area):
	if area.is_in_group("obstacles") and not animation_player.is_playing():
		animation_player.play("hit")
