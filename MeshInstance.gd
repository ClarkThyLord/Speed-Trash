extends MeshInstance


func _process(delta):
	translation.z += 10 * delta
	if translation.z >= 0.715:
		translation.z = -10.795
		translation.x = rand_range(-5, 5)
