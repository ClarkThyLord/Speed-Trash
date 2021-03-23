extends KinematicBody



## Exported Variables
export var speed := 30.0



## Built-In Virtual Methods
func _process(delta):
	if translation.z >= 1:
		reset()


func _physics_process(delta):
	var choque = move_and_collide(Vector3.BACK * speed * delta)
	if (choque is KinematicCollision):
		reset()
 


## Public Methods
func reset() -> void:
	translation.z = -45
	translation.x = rand_range(-3, 3)
