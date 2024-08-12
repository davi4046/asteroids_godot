extends Node2D


func _on_area_2d_body_exited(body):
	body.set_physics_process(false)
	body.global_position = Vector2(-body.global_position.x, -body.global_position.y)
	body.set_physics_process(true)


var rng = RandomNumberGenerator.new()
var timer = Timer.new()


func _ready():
	timer.connect("timeout", _spawn_meteor)	
	add_child(timer)	
	timer.start(rng.randf_range(0, 3))
	_spawn_meteor()		


func _spawn_meteor():
	var meteors = [
		preload("res://scenes/meteors/meteor_big_1.tscn"),
		preload("res://scenes/meteors/meteor_big_2.tscn"),
		preload("res://scenes/meteors/meteor_big_3.tscn"),
		preload("res://scenes/meteors/meteor_big_4.tscn")
	]
	var meteor_type = meteors[rng.randi_range(0, 3)]
	var meteor = meteor_type.instantiate()
	
	var pos
	if rng.randi_range(0,1)==0:
		var x = 650 if rng.randi_range(0,1)==0 else -650
		var y = rng.randf_range(-324, 324)
		pos = Vector2(x, y)
	else:
		var x = rng.randf_range(-576, 576)
		var y = 400 if rng.randi_range(0,1)==0 else -400
		pos = Vector2(x, y)
	
	var vel = pos * -0.25
	
	meteor.global_position = pos
	meteor.linear_velocity = vel
	add_child(meteor)
	
	timer.start(rng.randf_range(5, 10))
