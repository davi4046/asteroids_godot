extends RigidBody2D


func _ready():
	var timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", queue_free)
	timer.start(8)


func _on_area_2d_body_entered(body):
	body.emit_signal("body_entered", self)
	queue_free()	
