extends Node

const  MAX_RANGE = 150

@export var sword_ability: PackedScene
var damage = 5
 

# Called when the node enters the scene tree for the first time.
func _ready():
	# Equivalent sugared syntax to get_node("Timer") 
	$Timer.timeout.connect(on_timer_timeout)

# Adds the sword instance to the main scene
func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
		
	var enemies = get_tree().get_nodes_in_group("enemy")
	enemies = enemies.filter(func(enemy: Node2D): 
		# Calculating the actual distance between two points involves taking the square
		# root of the squared distance, which is computationally expensive. However, 
		# for comparing distances, the actual distance isn't required – knowing which 
		# distance is smaller suffices. By comparing squared distances, you avoid the 
		#costly square root operation, making the calculation faster.
		return enemy.global_position.distance_squared_to(player.global_position) < pow(MAX_RANGE, 2)
	)
	
	if enemies.size() == 0:
		return 
		
	enemies.sort_custom(func(a: Node2D, b: Node2D):
		var a_distance = a.global_position.distance_squared_to(player.global_position)
		var b_distance = b.global_position.distance_squared_to(player.global_position)
		return a_distance < b_distance
	)
	
	var sword_instance = sword_ability.instantiate() as SwordAbility
	# Add a sword instance as a child of the player node
	player.get_parent().add_child(sword_instance)
	sword_instance.hitbox_component.damage = damage 
	
	sword_instance.global_position = enemies[0].global_position
	# Vector that rotates in a range of 0 to 360 (TAU == 2π)
	sword_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU))
	
	# Rotates the sword to the enemy
	var enemy_direction = enemies[0].global_position - sword_instance.global_position
	sword_instance.rotation = enemy_direction.angle()
