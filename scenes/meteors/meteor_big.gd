extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", _on_body_entered)


func _on_body_entered(body: Node):
	var meteor_med_1 = preload("res://scenes/meteors/meteor_med_1.tscn")
	var meteor_med_2 = preload("res://scenes/meteors/meteor_med_2.tscn")
	
	var parent = get_parent()
	var rng = RandomNumberGenerator.new()
	
	for i in 3:
		var meteor_type = meteor_med_1 if i%2==0 else meteor_med_2
		var meteor = meteor_type.instantiate()
		var offset_x = randf_range(-20, 20)
		var offset_y = randf_range(-20, 20)
		meteor.global_position = global_position + Vector2(offset_x, offset_y)
		parent.add_child(meteor)
	
	queue_free()
