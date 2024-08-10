extends Node2D


func _on_area_2d_body_exited(body):
	body.set_physics_process(false)
	body.global_position = Vector2(-body.global_position.x, -body.global_position.y)
	body.set_physics_process(true)
