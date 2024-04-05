extends GridMap

var START_POINT: Node3D;
var END_POINT: Area3D;
var CLONE_TRIGGERS: Array[Area3D] = [];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	START_POINT = $start;
	END_POINT = $end;
	
	for child in self.get_children():
		if (child.is_in_group("clone_trigger")):
			CLONE_TRIGGERS.append(child);

func notifyDeath():
	if (get_tree().get_nodes_in_group("players").size() == 0):
		$GUI.changeGUI(2);

