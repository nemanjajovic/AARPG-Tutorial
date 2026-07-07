class_name State_Walk extends State

@export var move_speed : float = 100.0
@onready var idle: State = $"../Idle"
@onready var attack: State = $"../Attack"

# What happenes when the player enters this state?
func Enter() -> void:
	player.UpdateAnimation("walk")
	pass

# What happenes when the player exits this state?
func Exit() -> void:
	pass

# What happenes during the _process update in this state?
func Process(_delta : float) -> State:
	return null

# What happenes during the _physics_process update in this state?
func Physics( _delta: float) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	player.velocity = player.direction * move_speed
	
	if player.SetDirection():
		player.UpdateAnimation("walk")
		
	return null

# What happenes with input events in this state?
func HandleInput(_event: InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	return null
