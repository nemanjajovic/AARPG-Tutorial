class_name State extends Node

# Stores a referenece to the player that this state belongs to
static var player: Player

func _ready() -> void:
	pass


# What happenes when the player enters this state?
func Enter() -> void:
	pass

# What happenes when the player exits this state?
func Exit() -> void:
	pass

# What happenes during the _process update in this state?
func Process(_delta : float) -> State:
	return null

# What happenes during the _physics_process update in this state?
func Physics( _delta: float) -> State:
	return null

# What happenes with input events in this state?
func HandleInput(_event: InputEvent) -> State:
	return null
