extends CharacterBody2D

@export var move_speed : float = 100
@export var accel : float = 8
@export var starting_direction : Vector2 = Vector2(0, 1)
@export var current_tool: DataTypes.Tools = DataTypes.Tools.None
@export var hit_component_collision_shape: CollisionShape2D

@onready var animation_tree : AnimationTree = $AnimationTree

var is_chopping : bool = false

func _ready():
	update_animation_parameters(starting_direction)
	hit_component_collision_shape.disabled = true
	hit_component_collision_shape.position = Vector2.ZERO

func _physics_process(_delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
		
	var input_direction = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")

	update_animation_parameters(input_direction)
	velocity.x = move_toward(velocity.x, input_direction.x * move_speed, accel)
	velocity.y = move_toward(velocity.y, input_direction .y * move_speed, accel)
	move_and_slide()

func update_animation_parameters(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Idle/blend_position", move_input)
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Chop/blend_position", move_input)
		animation_tree.

func check_for_actions():
	if Input.is_action_just_pressed("action"):
		is_chopping = true 
	if animation_tree


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	pass # Replace with function body.
