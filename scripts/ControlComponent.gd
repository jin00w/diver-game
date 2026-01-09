extends Node
class_name ControlComponent

var movement: MovementComponent
@export var fin_force := 1000.0

func _ready():
	movement = get_parent().get_node("MovementComponent")

func _physics_process(delta):
	var input_x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var input_y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	movement.apply_force(Vector2(input_x, input_y) * fin_force * delta)
	movement.process(delta)
