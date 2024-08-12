extends Control


func _on_play_button_button_down():
	GameMode.start_game()
	queue_free()
