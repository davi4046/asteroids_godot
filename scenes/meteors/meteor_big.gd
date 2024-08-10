extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", _on_body_entered)


func _on_body_entered(body: Node):
	var meteors = [
		preload("res://scenes/meteors/meteor_med_1.tscn"),
		preload("res://scenes/meteors/meteor_med_2.tscn")
	]

	var parent = get_parent()
	var rng = RandomNumberGenerator.new()
	
	for i in 3:
		var meteor_type = meteors[rng.randi_range(0,1)]
		var meteor = meteor_type.instantiate()
		var offset_x = randf_range(-20, 20)
		var offset_y = randf_range(-20, 20)
		meteor.global_position = global_position + Vector2(offset_x, offset_y)
		meteor.linear_velocity = linear_velocity + (meteor.global_position - global_position).normalized() * 25
		parent.add_child(meteor)
	
	queue_free()
