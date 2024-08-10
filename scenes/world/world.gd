extends Node2D


func _on_area_2d_body_exited(body):
	body.set_physics_process(false)
	body.global_position = Vector2(-body.global_position.x, -body.global_position.y)
	body.set_physics_process(true)


var rng = RandomNumberGenerator.new()
var timer = Timer.new()


func _ready():
	timer.connect("timeout", _spawn_meteor)	
	timer.start(rng.randf_range(2, 10))
	add_child(timer)
	_spawn_meteor()		


func _spawn_meteor():
	print("Spawn meteor!")	
	timer.start(rng.randf_range(2, 10))
	pass
