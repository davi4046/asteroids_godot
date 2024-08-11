extends Control


func _ready():
	Globals.connect("score_changed", _on_score_changed)


func _on_score_changed():
	$Score.text = str(Globals.score)
