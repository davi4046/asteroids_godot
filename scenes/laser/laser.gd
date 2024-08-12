extends RigidBody2D


func _ready():
	var timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", queue_free)
	timer.start(8)


func _on_area_2d_body_entered(body):
	body.emit_signal("body_entered", self)
	
	if body is MeteorBig:
		GameMode.score += 100
	elif body is MeteorMed:
		GameMode.score += 25
	
	var laser_hit = preload("res://scenes/laser_hit/laser_hit.tscn").instantiate()
	laser_hit.position = position
	get_parent().add_child(laser_hit)
	
	queue_free()
