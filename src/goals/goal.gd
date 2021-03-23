extends KinematicBody



## Exported Variables
export var speed := 30.0

export var pointage := 1



## Built-In Virtual Methods
func _process(delta):
	if translation.z >= 1:
		reset()


func _physics_process(delta):
	var hit = move_and_collide(Vector3.BACK * speed * delta)
	
	if (hit is KinematicCollision):
		if hit.collider.is_in_group("players"):
			collect()
		else:
			reset()
 


## Public Methods
func collect() -> void:
	get_node("/root/Session").points += pointage
	reset()


func reset() -> void:
	translation.z = -45
	translation.x = rand_range(-3, 3)
