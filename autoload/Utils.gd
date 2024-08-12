extends Node


func create_random_audio_2d(options) -> AudioStreamPlayer2D:
	var rng = RandomNumberGenerator.new()
	var sound = options[rng.randi_range(0, options.size() - 1)]
	
	var audio_player = AudioStreamPlayer2D.new()
	audio_player.stream = sound
	audio_player.autoplay = true
	audio_player.connect("finished", func(): audio_player.queue_free())
	
	return audio_player
