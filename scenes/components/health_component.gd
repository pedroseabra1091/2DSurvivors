extends Node
class_name HealthComponent

signal died

@export var max_health: float = 10
var current_health

func _ready():
	current_health = max_health

func damage(damage_amount: float):
	current_health = max(max_health - damage_amount, 0)
	# Call function only on idle frames
	Callable(check_death).call_deferred()
	
func check_death():
	if current_health == 0:
		died.emit()
		owner.queue_free()
