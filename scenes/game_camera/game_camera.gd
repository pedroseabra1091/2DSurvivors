extends Camera2D

var target_position = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	# When camera is ready, is set as current.
	make_current()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	acquire_target()
	# Linear interpolation – Specifies a percentage between the distance of two points.
	# Represents a point between the 2 points supplied by a given percentage.
	# The statement below creates a smooth lerping
	global_position = global_position.lerp(target_position, 1.0 - exp(-delta * 20))
		
		
func acquire_target():
		# Gets all nodes in the group
	var player_nodes = get_tree().get_nodes_in_group("player")
	if player_nodes.size() > 0:
		# Cast to Node2D allows the intelisense to kick in
		var player = player_nodes[0] as Node2D
		target_position = player.global_position
	
		
