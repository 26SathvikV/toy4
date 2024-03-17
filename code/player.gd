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

func initialize() -> void:
	pass;

func _physics_process(delta: float) -> void:
	var vec: Vector3 = Vector3(0, self.velocity.y - gravity * delta, 0);

	for dir in mappedDirections:
		vec += mappedDirections[dir] if Input.is_action_pressed(dir) else Vector3();
	
	if (Input.is_action_just_pressed("jump") && self.is_on_floor()):
		vec.y = jumpHeight;
	
	self.velocity = vec;
	move_and_slide();
