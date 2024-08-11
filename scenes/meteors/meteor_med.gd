extends RigidBody2D


class_name MeteorMed


func _ready():
	var timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", _on_timer_timeout)
	timer.one_shot = true	
	timer.start(0.1)


func _on_timer_timeout():
	connect("body_entered", _on_body_entered)


func _on_body_entered(_body: Node):
	queue_free()
