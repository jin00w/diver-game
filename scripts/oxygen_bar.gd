extends Node2D

var oxygen_component
var bar

func _ready():
	bar = $ProgressBar
	oxygen_component = get_parent().get_node("OxygenComponent")
	
func _process(delta):
	bar.value = oxygen_component.oxygen
