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
			color = Color(0.082353, 0.082353, 0.082353)
		TrashTypes.PAPER:
			color = Color(0, 0.215686, 1)
		TrashTypes.GLASS:
			color = Color.white
		TrashTypes.METAL:
			color = Color(1, 0.92549, 0)
		TrashTypes.PLASTIC:
			color = Color(1, 0.568627, 0)
		TrashTypes.E_WASTE:
			color = Color.red
		_:
			return
	trash_type = value
	
	texture.modulate = color
