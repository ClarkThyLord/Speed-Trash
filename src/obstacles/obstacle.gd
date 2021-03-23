extends KinematicBody



## Exported Variables
export var speed := 30.0

export var penalty := 0



## Built-In Virtual Methods
func _process(delta):
	if translation.z >= 1:
		reset()


func _physics_process(delta):
	var hit = move_and_collide(Vector3.BACK * speed * delta)
	if (hit is KinematicCollision):
		if hit.collider.is_in_group("players"):
			crash()
 


## Public Methods
func crash() -> void:
	if penalty == 0:
		get_node("/root/Session").points = 0
	else:
		get_node("/root/Session").points += penalty
	reset()

func reset() -> void:
	translation.z = -45
	translation.x = rand_range(-3, 3)
