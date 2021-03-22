extends Spatial



func _process(delta):
	if Input.is_action_pressed("ui_right") and translation.x < 5:
		translation.x += 10 * delta
	if Input.is_action_pressed("ui_left") and translation.x > -5:
		translation.x -= 10 * delta
