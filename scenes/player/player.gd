extends CharacterBody2D

const MAX_SPEED = 125
const ACCELERATION_SMOOTHING = 15

# Called when node tree enters the scene tree – when all nodes are ready.
func _ready():
	pass

# Called every frame. `delta` is the elapsed time from the previous frame.
func _process(delta):
	var movement_vector = get_movement_vector()
	# The input vector needs to be normalized, otherwise the movement vector might surpass 1.
	# Instances like this can happen if 2 inputs are pressed simultaneously.
	var direction = movement_vector.normalized()
	var target_velocity = direction * MAX_SPEED
	
	# Enforces a smooth linear interpolation, artificially creating acceleration
	velocity = velocity.lerp(target_velocity, 1 - exp(-delta * ACCELERATION_SMOOTHING))
	
	move_and_slide()
	

func get_movement_vector():
	# Movement is calculated by dividing the positive delta against the negative delta.
	#
	# On the horizontal axis, right produces a positive offset while left produces a negative offset.
	# On the vertical axis, down produces a positive offset while up produces a negative offset.
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	return Vector2(x_movement, y_movement)
