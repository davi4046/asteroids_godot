extends RigidBody2D
class_name Meteor


var impact_sounds = []


func _init(impact_sounds):
	self.impact_sounds = impact_sounds


func _ready():
	connect("body_entered", _on_body_entered)


func _on_body_entered(_body: Node):
	_on_destroyed()
	_play_impact_sound()
	queue_free()


func _on_destroyed():
	pass


func _play_impact_sound():
	var rng = RandomNumberGenerator.new()
	var sound = impact_sounds[rng.randi_range(0, impact_sounds.size() - 1)]
	
	var audio_player = AudioStreamPlayer2D.new()
	audio_player.position = position
	audio_player.stream = sound	
	
	var remove_audio_player = func():
		audio_player.queue_free()
	
	audio_player.connect("finished", remove_audio_player)
	
	get_parent().add_child(audio_player)
	audio_player.play()
