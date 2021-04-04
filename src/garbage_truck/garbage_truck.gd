extends KinematicBody



## Exported Variables
export var speed := 10.0



## Built-In Virtual Methods
func _process(delta):
	var direction := Vector3.ZERO
	if Input.is_action_pressed("ui_right") and translation.x < 6:
		direction += Vector3.RIGHT
	if Input.is_action_pressed("ui_left") and translation.x > -6:
		direction += Vector3.LEFT
	
	move_and_collide(direction * speed * delta)
