extends Node


signal score_changed
signal lives_changed


var score: int:
	set = set_score


var lives: int:
	set = set_lives


var world: World
var hud: Hud


func _ready():
	world = preload("res://scenes/world/world.tscn").instantiate()
	get_tree().current_scene.add_child(world)


func set_score(value: int):
	score = value
	emit_signal("score_changed")


func set_lives(value: int):
	lives = value
	emit_signal("lives_changed")


func start_game():
	for meteor in get_tree().get_nodes_in_group("meteor"):
		meteor.queue_free()
	score = 0
	lives = 3
	hud = preload("res://ui/hud/hud.tscn").instantiate()
	get_parent().add_child(hud)
	_spawn_player()
	world.start_spawning_meteors()


func _end_game():
	hud.queue_free()
	var start_menu = preload("res://ui/start_menu/start_menu.tscn").instantiate()
	get_tree().current_scene.add_child(start_menu)
	world.stop_spawning_meteors()


func _spawn_player():
	var player = preload("res://scenes/player/player.tscn").instantiate()
	player.connect("player_died", _on_player_died)
	world.call_deferred("add_child", player)


func _on_player_died():
	lives -= 1
	if lives == 0:
		_end_game()
	else:
		_spawn_player()
