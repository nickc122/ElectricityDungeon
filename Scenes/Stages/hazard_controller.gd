extends Node2D

var children

func _ready() -> void:
	children = get_children()
	print(children)
	

func hazard_on():
	for child in children:
		child.hazard_on()

func hazard_off():
	for child in children:
		child.hazard_off()
