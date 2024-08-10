extends Node2D


func _ready():
	var rng = RandomNumberGenerator.new()
	rotation = rng.randf_range(0, 1)
	
	var timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", queue_free)
	timer.start(0.1)
