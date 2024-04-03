extends CharacterBody3D

@export var speed: float;
@export var jumpHeight: float;
@export var gravity: float;

@onready var mappedDirections: Dictionary = { # godot doesnt have dictionary type hints?
	"up": Vector3(speed, 0, 0), # note that up is in 2d plane, not 3d (ie jump)
	"down": Vector3(-speed, 0, 0),
	"right": Vector3(0, 0, speed),
	"left": Vector3(0, 0, -speed)
};

var isDead: bool = false;
var _vel: Vector3; # backup of velocity that is not modifed by move_and_slide
var currAnim

func initialize() -> void:
	add_to_group("players");

func _physics_process(delta: float) -> void:
	currAnim = 'Idle'
	
	# allow for pushing of dead players
	for i in self.get_slide_collision_count():
		var collision: KinematicCollision3D = self.get_slide_collision(i);
		var col: Object = collision.get_collider();
		if (col == null):
			continue;
		# so for some reason im only able to access metadata? and not groups?
		# aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
		if (!col.has_meta("player")):
			continue;
		
		col._vel = _vel * Vector3(1, 0, 1);
		col.velocity = col._vel;
		col.move_and_slide();
		
	if (isDead):
		self._vel = Vector3(0, self._vel.y, 0);
		return;

	_vel = Vector3(0, self.velocity.y - gravity * delta, 0);
	var direction = 0

	for dir in mappedDirections:
		_vel += mappedDirections[dir] if Input.is_action_pressed(dir) else Vector3();
		#direction += mappedDirections[dir] if Input.is_action_pressed(dir) else 0;
		currAnim = 'Walking_B'
	
	if (Input.is_action_just_pressed("jump") && self.is_on_floor()):
		_vel.y = jumpHeight;
	
	if (!is_on_floor()):
		currAnim = "Jump_Idle"
	
	if (isDead):
		currAnim = "Death_A_Pose"
	
	self.velocity = _vel;
	rotation.y = direction
	$Rogue/AnimationPlayer.current_animation = currAnim
	move_and_slide();

func kill() -> void:
	self.remove_from_group("player");
	remove_from_group("players")
	isDead = true;
	$collision/AnimationPlayer.current_animation = "dead"
	$Rogue/AnimationPlayer.current_animation = "Death_A_Pose"
	get_node("/root/main/level").get_child(0).notifyDeath();
