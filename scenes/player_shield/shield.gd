extends StaticBody2D


func _process(_delta):
	global_rotation = 0


func _on_timer_timeout():
	queue_free()
