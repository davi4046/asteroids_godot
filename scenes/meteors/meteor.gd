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
	var audio_player = Utils.create_random_audio_2d(impact_sounds)
	audio_player.position = position
	audio_player.volume_db = 6
	get_parent().add_child(audio_player)
