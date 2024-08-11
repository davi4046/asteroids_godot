extends Node


signal score_changed


var score = 0:
	set = set_score


func set_score(value):
	score = value
	emit_signal("score_changed")
