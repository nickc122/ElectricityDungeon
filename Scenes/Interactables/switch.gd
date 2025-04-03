extends StaticBody2D

class_name Interactable

var is_switched: bool = false

func _ready() -> void:
	if is_switched: #sets up the button on loading (doesn't do anything yet)
		$AnimatedSprite2D.play("on")
		

func _process(_delta: float) -> void: #debug
	if Input.is_action_just_pressed("debug_button"): #a stand-in to test this
		on_interaction()

func on_interaction(): #called by player, a universal function name for all interactables
	if is_switched: #turns off animation if on
		$AnimatedSprite2D.play("off")
	elif not is_switched: #turns on animation if off
		$AnimatedSprite2D.play("on")
	is_switched = !is_switched #toggles the status variable
