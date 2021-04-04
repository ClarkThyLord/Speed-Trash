tool
extends Area
# Abstract class for all map objects



## Exported Variables
export var speed := 1.0

export var pointage := 0.0



## Built-In Virtual Methods
func _ready() -> void:
	add_to_group("objects")
	
	connect("body_entered", self, "_on_body_entered")



## Public Methods
func random() -> void: pass


func player_entered(player) -> void:
	get_node("/root/Session").points += pointage



## Private Methods
func _on_body_entered(body) -> void:
	if body is KinematicBody and body.is_in_group("players"):
		player_entered(body)
