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
	_play_impact_sound()
	
	queue_free()

func _play_impact_sound():
	var sounds = [
		preload("res://assets/audio/footstep_grass_000.ogg"),
		preload("res://assets/audio/footstep_grass_001.ogg"),
		preload("res://assets/audio/footstep_grass_002.ogg"),
		preload("res://assets/audio/footstep_grass_003.ogg"),
		preload("res://assets/audio/footstep_grass_004.ogg")
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
