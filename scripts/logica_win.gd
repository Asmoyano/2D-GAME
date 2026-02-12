extends Node2D

var total_collectibles := 0
var collected := 0
@onready var timer = $Timer
@onready var label = $Label2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	total_collectibles = get_tree().get_nodes_in_group("collectibles").size()

func _on_collectible_collected():
	collected += 1
	$Label.text = "Objetos: %d" % collected
	
	if collected >= total_collectibles: win_game()

func win_game():
	print("Ganaste")

func _process(delta: float) -> void:
	label.text = "Tiempo: %d" % int(timer.time_left)

func _on_timer_timeout() -> void:
	lose_game()

func lose_game():
	print("Perdiste")
