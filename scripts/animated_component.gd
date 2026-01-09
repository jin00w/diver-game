extends Node

var sprite: AnimatedSprite2D
var movement_component: Node

func _ready():
	sprite = get_parent().get_node("AnimatedSprite2D")
	movement_component = get_parent().get_node("MovementComponent")

func _process(delta):
	if movement_component == null or sprite == null:
		return

	var velocity = movement_component.velocity

	var anim = ""
	if velocity.length() > 0.15:
		anim = "swim"
		sprite.flip_h = velocity.x < 0
	else:
		anim = "idle"

	if sprite.animation != anim:
		sprite.play(anim)
