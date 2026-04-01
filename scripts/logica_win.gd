extends Node2D

enum GameState {PLAYING, WON, LOST}
var game_state = GameState.PLAYING

var total_collectibles := 0
var collected := 0
@onready var timer = $Timer
@onready var label = $Label2
@onready var game_over_ui = $GameOverUI
@onready var result_label = $GameOverUI/Panel/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	total_collectibles = get_tree().get_nodes_in_group("collectibles").size()

func _on_collectible_collected():
	collected += 1
	$Label.text = "Objetos: %d" % collected
	
	if collected >= total_collectibles: win_game()

func win_game():
	game_state = GameState.WON
	timer.stop()
	show_win_screen()

func _process(delta: float) -> void:
	label.text = "Tiempo: %d" % int(timer.time_left)

func _on_timer_timeout() -> void:
	lose_game()

func lose_game():
	game_state = GameState.LOST
	timer.stop()
	show_lose_screen()

func show_win_screen():
	result_label.text = "¡Ganaste!"
	game_over_ui.visible = true

func show_lose_screen():
	result_label.text = "Perdiste"
	game_over_ui.visible = true


func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
