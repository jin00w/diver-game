extends Node
class_name OxygenComponent

@export var max_oxygen := 100.0
@export var drain_rate := 2.0 # oxygen per second

var oxygen := max_oxygen

func _ready():
	oxygen = max_oxygen

func _process(delta):
	oxygen -= drain_rate * delta
	oxygen = max(oxygen, 0)
