extends Node


signal score_changed


var score = 0:
	set = set_score


var world: World


func _ready():
	world = preload("res://scenes/world/world.tscn").instantiate()
	get_tree().current_scene.add_child(world)


func set_score(value):
	score = value
	emit_signal("score_changed")


func start_game():
	var hud = preload("res://ui/hud/hud.tscn").instantiate()
	get_parent().add_child(hud)
	_spawn_player()
	world.start_spawning_meteors()


func _spawn_player():
	var player = preload("res://scenes/player/player.tscn").instantiate()
	player.connect("player_died", _on_player_died)
	world.add_child(player)


func _on_player_died():
	_spawn_player()
