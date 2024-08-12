extends Meteor
class_name MeteorBig


func _init():
	super._init([
		preload("res://assets/audio/footstep_snow_000.ogg"),
		preload("res://assets/audio/footstep_snow_001.ogg"),
		preload("res://assets/audio/footstep_snow_002.ogg"),
		preload("res://assets/audio/footstep_snow_003.ogg"),
		preload("res://assets/audio/footstep_snow_004.ogg")
	])


func _on_destroyed():
	var meteors = [
		preload("res://scenes/meteors/meteor_med_1.tscn"),
		preload("res://scenes/meteors/meteor_med_2.tscn")
	]
	
	var rng = RandomNumberGenerator.new()
	var number_of_pieces = rng.randi_range(3, 5)
	
	for i in number_of_pieces:
		var meteor_type = meteors[rng.randi_range(0, meteors.size() - 1)]
		var meteor = meteor_type.instantiate()
		var offset_x = randf_range(-25, 25)
		var offset_y = randf_range(-25, 25)
		var new_position = global_position + Vector2(offset_x, offset_y)
		var new_velocity = linear_velocity + (new_position - global_position).normalized() * 25
		meteor.set_deferred("global_position", new_position)
		meteor.set_deferred("linear_velocity", new_velocity)
		get_parent().call_deferred("add_child", meteor)
