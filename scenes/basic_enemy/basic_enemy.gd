extends CharacterBody2D

const MAX_SPEED = 40

# Called when node tree enters the scene tree – when all nodes are ready.
func _ready():
	$Area2D.area_entered.connect(on_area_entered)

# Called every frame. `delta` is the elapsed time from the previous frame.
func _process(_delta):
	var direction = get_direction_to_player()
	velocity = direction * MAX_SPEED
	move_and_slide()
	
func get_direction_to_player():
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if player_node != null:
		return (player_node.global_position - global_position).normalized()
	return Vector2.ZERO
	
func on_area_entered(_other_area: Area2D):
	## Frees the entity from the scene and memory
	queue_free()
