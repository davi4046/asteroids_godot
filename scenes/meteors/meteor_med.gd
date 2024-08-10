extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = Timer.new()
	timer.connect("timeout", _on_timer_timeout)
	add_child(timer)
	timer.start(0.1)


func _on_timer_timeout():
	connect("body_entered", _on_body_entered)


func _on_body_entered(body: Node):
	queue_free()
