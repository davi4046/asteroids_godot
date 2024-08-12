extends Control
class_name Hud


func _ready():
	GameMode.connect("score_changed", _on_score_changed)
	GameMode.connect("lives_changed", _on_lives_changed)
	_update_score(GameMode.score)
	_update_lives(GameMode.lives)


func _on_score_changed():
	_update_score(GameMode.score)


func _on_lives_changed():
	_update_lives(GameMode.lives)


func _update_score(score: int):
	$Score.text = str(score)


func _update_lives(lives: int):
	for child in $LivesContainer.get_children():
		$LivesContainer.remove_child(child)
	
	for i in lives:
		var player_life = preload("res://ui/hud/player_life/player_life.tscn").instantiate()
		$LivesContainer.add_child(player_life)
