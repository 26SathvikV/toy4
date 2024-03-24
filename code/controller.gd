extends Node3D

# key:
# (required)
# 	nClones: maximum allowed clones in level
# 	path: path to level scene
# (optional)
# 	next: the next level to load once the player beats the current level. if not set will go to menu
const GAME_DATA: Array[Dictionary] = [
	{ # level 0
		"nClones": 3,
		"path": "res://resources/levels/level1.tscn",
		"next": null
	}
];

# TODO
var currentLevel: GridMap = null;
var currentLevelIndex: int = -1; # test
var nClones: int = 0;
var maxClones: int = 3;

func _ready():
	loadLevel(0);

func loadLevel(index: int) -> void:
	unloadLevel(currentLevelIndex);

	var data: Dictionary = GAME_DATA[index];
	
	currentLevel = load(data["path"]).instantiate();
	get_node("/root/main/level").add_child(currentLevel);
	nClones = 1;
	maxClones = data["nClones"];
	
	currentLevel.ready.connect(loadLevelCallback);

func loadLevelCallback() -> void:
	var player: Node3D = get_node("/root/Resources").player.instantiate();
	get_node("/root/main/playerCharacters").add_child(player);
	player.position = currentLevel.START_POINT.position;
	player.initialize();
	
	currentLevel.ready.disconnect(loadLevelCallback);

func unloadLevel(index: int) -> void:
	pass
