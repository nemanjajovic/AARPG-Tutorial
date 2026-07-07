class_name State_Attack extends State

var attacking : bool = false

@export var attack_sound : AudioStream
@export_range(1,20,0.5) var decelerate_speed : float = 5.0
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var walk: State = $"../Walk"
@onready var idle: State = $"../Idle"
@onready var attack_effect: AnimationPlayer = $"../../Sprite2D/AttackEffectSprite/AnimationPlayer"
@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"
@onready var attack: State_Attack = $"."
@onready var hurt_box: HurtBox = $"../../Interactions/HurtBox"

# What happenes when the player enters this state?
func Enter() -> void:
	player.UpdateAnimation("attack")
	attack_effect.play("attack_" + player.AnimDirection())
	animation_player.animation_finished.connect(EndAttack)
	audio.stream = attack_sound
	audio.pitch_scale = randf_range(0.9, 1.1)
	audio.play()
	
	attacking = true
	
	await get_tree().create_timer(0.075).timeout
	hurt_box.monitoring = true
	pass

# What happenes when the player exits this state?
func Exit() -> void:
	animation_player.animation_finished.disconnect(EndAttack)
	attacking = false
	hurt_box.monitoring = false
	pass

# What happenes during the _process update in this state?
func Process(_delta : float) -> State:
	return null

# What happenes during the _physics_process update in this state?
func Physics( _delta: float) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	return null

# What happenes with input events in this state?
func HandleInput(_event: InputEvent) -> State:
	return null

func EndAttack(_newAnimName: String) -> void:
	attacking = false
