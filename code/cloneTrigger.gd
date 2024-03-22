extends Area3D

var isActive: bool = false;
var activeBody: Node3D = null;

func _on_body_entered(body: Node3D) -> void:
	if (isActive || !body.is_in_group("player")):
		return;
	
	# check if we can still have more clones
	var con: Node3D = get_node("/root/Controller");
	if (con.nClones < con.maxClones):
		isActive = true;
		activeBody = body;

		# TODO: check if spawn point is blocked
		var p: Node3D = get_node("/root/Resources").player.instantiate();
		# surely theres a better way to do this??
		# there is. use signals :)
		get_tree().root.get_node("main/playerCharacters").add_child(p);

		p.position = $spawnPoint.position;
		p.initialize();

func _on_body_exited(body: Node3D) -> void:
	if (body == activeBody):
		isActive = false;
		activeBody = null;
