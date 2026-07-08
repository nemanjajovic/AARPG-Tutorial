class_name Player extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var movement_action_stack : Array[String] = []
const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine

signal DirectionChanged(new_direction: Vector2)

func _ready() -> void:
	state_machine.Initialize(self)
	
	
func _physics_process(_delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down") # get_vector returns Vector2 needed for direction variable
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		var key_event := event as InputEventKey
		if key_event.echo:
			return
	
	for action in ["left", "right", "up", "down"]:
		if event.is_action_pressed(action):
			movement_action_stack.erase(action)
			movement_action_stack.append(action)
		elif event.is_action_released(action):
			movement_action_stack.erase(action)

func SetDirection() -> bool:
	if direction == Vector2.ZERO:
		return false
	var new_dir : Vector2 = cardinal_direction
	
	if movement_action_stack.size() > 0:
		match movement_action_stack.back():
			"left":
				new_dir = Vector2.LEFT
			"right":
				new_dir = Vector2.RIGHT
			"up":
				new_dir = Vector2.UP
			"down":
				new_dir = Vector2.DOWN
	else:
		if direction.x < 0:
			new_dir = Vector2.LEFT
		elif direction.x > 0:
			new_dir = Vector2.RIGHT
		elif direction.y < 0:
			new_dir = Vector2.UP
		elif direction.y > 0:
			new_dir = Vector2.DOWN
	
	if new_dir == cardinal_direction:
		return false
	
	cardinal_direction = new_dir
	
	DirectionChanged.emit(new_dir)
	
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true


func UpdateAnimation(state: String) -> void:
	animation_player.play(state + "_" + AnimDirection())

func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
