class_name AudioPlayer
extends Node;

static var instance: AudioPlayer;

@onready var bass = $bass
@onready var chords_1 = $chords1
@onready var chords_2 = $chords2
@onready var drums = $drums

@onready var spawn = $spawn
@onready var death = $death

var order
var pointer = 0

func _init():
	instance = self

func _ready():
	order = [bass, chords_1, chords_2, drums]
	
	for sound in order:
		sound.set_volume_db(-80.0)
		sound.play()

func onPlayerSpawn():
	if pointer < order.size():
		order[pointer].set_volume_db(0.0)
	#spawn.play() # i kind of like it better without this sound effect
	pointer += 1

func onPlayerExit():
	pointer -= 1
	if pointer < order.size():
		order[pointer].set_volume_db(-80.0)
	#death.play() # i kind of like it better without this sound effect
	print("exit")
