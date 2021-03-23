extends KinematicBody



func _process(delta):
	if Input.is_action_pressed("ui_right") and translation.x < 5:
		translation.x += 10 * delta
	if Input.is_action_pressed("ui_left") and translation.x > -5:
		translation.x -= 10 * delta

#func is_colliding():
	#var normal = get_collision_normal()
	#movimiento = normal.slide(movimiento)
	#velocidad = normal.slide(velocidad)
	#move(movimiento)
	#if(normal.y < 0):
		#salto = false
		
#func procesar_colision():
	#var obj_colision = get_collider()
	#if(obj_colision.is_in_group("MeshInstance")):
		#print("Choque")

		
