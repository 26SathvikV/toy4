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

func initialize() -> void:
	pass;

func _ready():
	if !AudioPlayer.instance.is_node_ready():
		await AudioPlayer.instance.ready
	AudioPlayer.instance.onPlayerSpawn()

func _physics_process(delta: float) -> void:
	# allow for pushing of dead players
	for i in self.get_slide_collision_count():
		var collision: KinematicCollision3D = self.get_slide_collision(i);
		var col: Object = collision.get_collider();
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

	for dir in mappedDirections:
		_vel += mappedDirections[dir] if Input.is_action_pressed(dir) else Vector3();
	
	if (Input.is_action_just_pressed("jump") && self.is_on_floor()):
		_vel.y = jumpHeight;
	
	self.velocity = _vel;
	move_and_slide();

func kill() -> void:
	self.remove_from_group("player");
	isDead = true;
	AudioPlayer.instance.onPlayerExit();
	$mesh.set_surface_override_material(0, get_node("/root/Resources").deadPlayerMat);
