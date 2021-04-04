tool
extends Area
# Abstract class for all map objects


export var speed := 1.0

export var pointage := 0.0



## Built-In Virtual Methods
func _ready() -> void:
	add_to_group("objects")
	
	connect("body_entered", self, "_on_body_entered")



## Public Methods
func _player_entered(player) -> void: pass



## Private Methods
func _on_body_entered(body) -> void:
	if body is KinematicBody and body.is_in_group("players"):
		_player_entered(body)
