extends CharacterBody2D

const speed: int = 250
const jump_speed: int = -400
var times_jumped: int = 0
const player_name: String = "Cricket"
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var name_label: Label = $Label

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func _ready() -> void:
	name_label.text = player_name

func _physics_process(delta: float) -> void:
	player_movment()
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()


func player_movment() -> void:
	var dir = Input.get_axis("move_left", "move_right");
	if dir:
		velocity.x = dir * speed
		if is_on_floor():
			if dir > 0:
				play_anim("run", false)
			else:
				play_anim("run", true)
		else:
			if dir > 0:
				play_anim("jump_side", false)
			else:
				play_anim("jump_side", true)
	else:
		velocity.x = 0
		if is_on_floor():
			play_anim("idle", anim.flip_h)


	if is_on_floor():
		times_jumped = 0

	if Input.is_action_just_pressed("jump") and times_jumped < 2:
		velocity.y = jump_speed
		times_jumped += 1


func play_anim(animation: String, flip: bool) -> void:
	anim.flip_h = flip
	anim.play(animation)
