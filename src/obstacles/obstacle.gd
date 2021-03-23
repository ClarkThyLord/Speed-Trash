extends KinematicBody



## Built-In Virtual Methods
func _process(delta):
	if translation.z >= 1:
		reset()


func _physics_process(delta):
	var choque = move_and_collide(Vector3(0, 0, 30) * delta)
	if (choque is KinematicCollision):
		reset()
 


## Public Methods
func reset() -> void:
	translation.z = -25
	translation.x = rand_range(-3, 3)
