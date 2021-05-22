extends Area
## Garbage Truck



## Enums
enum AIModes {
	TRAINING,
	PLAYING
}



## Exported Variables
export var speed := 10.0

export(float, 0.0, 1.0) var deceleration := 0.25

export(float, 0.0, 1.0) var acceleration := 0.25

export(float, 0.0, 100.0) var boost_usage := 1.0

export(float, 0.0, 100.0) var break_usage := 1.0

export(float, 0.0, 100.0) var momentum := 0.0

export(float, 0.0, 100.0) var momentum_growth := 10.0

export var ai := false

export(AIModes) var ai_mode := AIModes.PLAYING



## Private Variables
var _breaking := false

var _boosting := false

var _moves := []



## OnReady Variables
onready var sprite : Sprite3D = get_node("Sprite3D")

onready var animation_player : AnimationPlayer = get_node("AnimationPlayer")

onready var view : Area = get_node("View")



## Built-In Virtual Methods
func _ready() -> void:
	sprite.modulate.a = 0.1 if (ai and ai_mode == AIModes.TRAINING) else 1.0


func _physics_process(delta : float) -> void:
	if ai:
		var state = " "
		
		var areas := view.get_overlapping_areas()
		if areas.size() > 1:
			for area in areas:
				if area == self:
					continue
				
				if area.translation.z < 0.0:
					state += "(" \
							+ str(round(area.translation.x)) \
							+ "," + str(area.pointage) + ")"
		
		var q_table := _get_q_table()
		
		var moves := [
			translation.x,
			clamp(translation.x + speed * delta, -6.0, 6.0),
			clamp(translation.x + -speed * delta, -6.0, 6.0),
		]
		
		var best_move = -INF
		var best_move_hash
		var best_move_value = -INF
		
		for move in moves:
			var move_state = str(move) + state
			print(move_state)
			var move_hash := hash(move_state)
			var move_value : float = q_table.get(move_hash, -INF)
			if move_value > best_move_value:
				best_move = move
				best_move_hash = move_hash
				best_move_value = move_value
		
		var exploration_rate := 0.2
		if best_move == -INF or \
				randf() <= exploration_rate:
			best_move = moves[randi() % moves.size()]
			best_move_hash = hash(str(best_move) + state)
		
		translation.x = best_move
		_moves.append(best_move_hash)
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
func _get_q_table() -> Dictionary:
	var session := get_node_or_null("/root/Session")
	return session.q_table if is_instance_valid(session) else {}


func _on_GargabeTruck_area_entered(area : Area):
	if area.is_in_group("objects"):
		var decay := 0.03
		var reward : float = area.pointage
		var q_table = _get_q_table()
		for move in _moves:
			if not q_table.has(move):
				q_table[move] = 0.0
			
			q_table[move] = float(q_table[move]) + reward
			reward -= reward * decay
		_moves.clear()
	
	if area.is_in_group("obstacles") and not animation_player.is_playing():
		animation_player.play("hit")
