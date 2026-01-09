extends Node
class_name MovementComponent

@export var drag := .92
@export var max_speed := 250.0
var velocity := Vector2.ZERO
var body: Node = null
var camera: Camera2D = null

func _ready():
	body = get_parent()  # assumes parent is the diver

func apply_force(force: Vector2):
	velocity += force

func process(delta):
	# Apply drag
	velocity *= drag
	# Clamp speed
	if velocity.length() > max_speed:
		velocity = velocity.normalized() * max_speed
	# Move the diver
	if "velocity" in body:
		body.velocity = velocity
	if "move_and_slide" in body:
		body.move_and_slide()
