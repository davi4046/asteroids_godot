extends RigidBody2D


class_name MeteorBig


func _ready():
	connect("body_entered", _on_body_entered)


func _on_body_entered(_body: Node):
	var meteors = [
		preload("res://scenes/meteors/meteor_med_1.tscn"),
		preload("res://scenes/meteors/meteor_med_2.tscn")
	]

	var rng = RandomNumberGenerator.new()
	var number_of_pieces = rng.randi_range(3, 5)
	
	for i in number_of_pieces:
		var meteor_type = meteors[rng.randi_range(0,1)]
		var meteor = meteor_type.instantiate()
		var offset_x = randf_range(-25, 25)
		var offset_y = randf_range(-25, 25)
		var new_position = global_position + Vector2(offset_x, offset_y)
		var new_velocity = linear_velocity + (new_position - global_position).normalized() * 25
		meteor.set_deferred("global_position", new_position)
		meteor.set_deferred("linear_velocity", new_velocity)
		get_parent().call_deferred("add_child", meteor)
	
	_play_impact_sound()
	
	queue_free()


func _play_impact_sound():
	var sounds = [
		preload("res://assets/audio/footstep_snow_000.ogg"),
		preload("res://assets/audio/footstep_snow_001.ogg"),
		preload("res://assets/audio/footstep_snow_002.ogg"),
		preload("res://assets/audio/footstep_snow_003.ogg"),
		preload("res://assets/audio/footstep_snow_004.ogg")
	]
	
	var rng = RandomNumberGenerator.new()
	var sound = sounds[rng.randi_range(0, sounds.size() - 1)]
	
	var audio_player = AudioStreamPlayer2D.new()
	audio_player.position = position
	audio_player.stream = sound	
	
	var remove_audio_player = func():
		audio_player.queue_free()
	
	audio_player.connect("finished", remove_audio_player)
	
	get_parent().add_child(audio_player)
	audio_player.play()
