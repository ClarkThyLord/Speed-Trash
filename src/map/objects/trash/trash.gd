tool
extends "res://src/map/objects/map_object.gd"



## Enums
enum TrashTypes {
	ORGANIC,
	PAPER,
	GLASS,
	METAL,
	PLASTIC,
	E_WASTE,
}



## Exported Variables
export(TrashTypes) var trash_type := 0 setget set_trash_type



## OnReady Variables
onready var texture : Sprite3D = get_node("Sprite3D")



## Built-In Virtual Methods
func _ready() -> void:
	set_trash_type(trash_type)



## Public Methods
func set_trash_type(value : int) -> void:
	var color : Color
	match trash_type:
		TrashTypes.ORGANIC:
			pointage = 1
			color = Color(0.082353, 0.082353, 0.082353)
		TrashTypes.PAPER:
			pointage = 2
			color = Color(0, 0.215686, 1)
		TrashTypes.GLASS:
			pointage = 3
			color = Color.white
		TrashTypes.METAL:
			pointage = 3
			color = Color(1, 0.92549, 0)
		TrashTypes.PLASTIC:
			pointage = 2
			color = Color(1, 0.568627, 0)
		TrashTypes.E_WASTE:
			pointage = 4
			color = Color.red
		_:
			return
	trash_type = value
	
	if is_instance_valid(texture):
		texture.modulate = color


func random() -> void:
	set_trash_type(randi() % TrashTypes.size())


func player_entered(player) -> void:
	.player_entered(player)
