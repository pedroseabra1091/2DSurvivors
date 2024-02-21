extends Node

# Assigns a node to the variable as soon as the node is ready
@onready var timer = $Timer

func get_time_elapsed():
	return $Timer.wait_time - $Timer.time_left
