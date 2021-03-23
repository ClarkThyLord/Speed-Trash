extends KinematicBody


func _process(delta):
	
	if translation.z >= 0.715:
		translation.z = -10.795
		translation.x = rand_range(-5, 5)

func _physics_process(delta):
	
	var choque = move_and_collide(Vector3(0,0,10 * delta))
	if (choque is KinematicCollision):
		print("Choque")
	
 
