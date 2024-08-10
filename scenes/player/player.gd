extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("Accelerate"):
		var force = Vector2.UP.rotated(global_rotation) * 10
		add_constant_central_force(force)
	
	if Input.is_action_just_pressed("Turn Left"):
		angular_velocity = -5
	
	if Input.is_action_just_pressed("Turn Right"):
		angular_velocity = 5
	
	if !Input.is_action_pressed("Turn Left") and !Input.is_action_pressed("Turn Right"):
		angular_velocity = 0
	
