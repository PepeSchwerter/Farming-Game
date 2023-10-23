extends CharacterBody2D

@export var move_speed : float = 100
@export var accel : float = 8
@export var starting_direction : Vector2 = Vector2(0, 1)

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")
func _ready():
	update_animation_parameters(starting_direction)

func _physics_process(_delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
		
	var input_direction = Input.get_vector("left", "right", "up", "down")

	update_animation_parameters(input_direction)
	velocity.x = move_toward(velocity.x, input_direction.x * move_speed, accel)
	velocity.y = move_toward(velocity.y, input_direction.y * move_speed, accel)
	pick_new_state()
	move_and_slide()

func update_animation_parameters(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Idle/blend_position", move_input)
		animation_tree.set("parameters/Walk/blend_position", move_input)

func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
