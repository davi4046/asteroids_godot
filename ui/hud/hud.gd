extends Control


func _ready():
	GameMode.connect("score_changed", _on_score_changed)


func _on_score_changed():
	$Score.text = str(GameMode.score)
