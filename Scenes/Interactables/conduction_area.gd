extends Area2D

#this is the script other conductive objects check to pass along conductivity
var active: bool #sets up a variable to receive info from parent
@onready var parent = get_parent() #initializes who the parent is

func _physics_process(_delta: float) -> void:
	active = parent.active #checks whether active on each frame
