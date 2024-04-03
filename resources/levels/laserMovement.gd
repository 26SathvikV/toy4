extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var uvOffset = Vector3(delta, 0, 0)
	get_active_material(0).set_uv1_offset(uvOffset)
