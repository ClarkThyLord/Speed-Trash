extends Spatial
## Training Trucks



## Exported Variables
export(int, 0, 100) var trucks := 10



## OnReady Variables
onready var training_truck := get_node("GargabeTruck")



## Built-In Virtual Methods
func _ready() -> void:
	for i in range(trucks):
		var truck = training_truck.duplicate()
		add_child(truck)
