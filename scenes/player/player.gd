extends RigidBody2D


signal player_died


var shoot_laser_timer = Timer.new()
var barrel_one = false


func _ready():
	shoot_laser_timer.one_shot = false
	shoot_laser_timer.wait_time = 0.15
	shoot_laser_timer.connect("timeout", shoot_laser)
	add_child(shoot_laser_timer)


func _process(_delta):
	if Input.is_action_pressed("Accelerate"):
		var force = Vector2.UP.rotated(global_rotation) * 25
		add_constant_central_force(force)
		
	if Input.is_action_just_pressed("Accelerate"):
		$ThrusterFire.visible = true
		$ThrusterFireAudio.play()
	elif Input.is_action_just_released("Accelerate"):
		$ThrusterFire.visible = false
		$ThrusterFireAudio.stop()
	
	if Input.is_action_just_pressed("Turn Left"):
		angular_velocity = -5
	
	if Input.is_action_just_pressed("Turn Right"):
		angular_velocity = 5
	
	if !Input.is_action_pressed("Turn Left") and !Input.is_action_pressed("Turn Right"):
		angular_velocity = 0
	
	if Input.is_action_just_pressed("Shoot Lasers"):
		shoot_laser_timer.start()
		shoot_laser()
	elif Input.is_action_just_released("Shoot Lasers"):
		shoot_laser_timer.stop()


func shoot_laser():
	var barrel = $Gun1/GunBarrel1 if barrel_one else $Gun2/GunBarrel2
	var laser = preload("res://scenes/laser/laser.tscn").instantiate()
	laser.global_position = barrel.global_position
	laser.global_rotation = barrel.global_rotation
	laser.linear_velocity = linear_velocity + Vector2.UP.rotated(global_rotation) * 750
	get_parent().add_child(laser)
	barrel_one = !barrel_one


func _on_body_entered(body):
	var audio_player = Utils.create_random_audio_2d([
		preload("res://assets/audio/explosionCrunch_000.ogg"),
		preload("res://assets/audio/explosionCrunch_001.ogg"),
		preload("res://assets/audio/explosionCrunch_002.ogg"),
		preload("res://assets/audio/explosionCrunch_003.ogg"),
		preload("res://assets/audio/explosionCrunch_004.ogg")
	])
	get_parent().add_child(audio_player)
	
	var explosion = preload("res://scenes/effects/player_explosion/player_explosion.tscn").instantiate()
	explosion.position = position
	get_parent().add_child(explosion)
	
	emit_signal("player_died")
	queue_free()
