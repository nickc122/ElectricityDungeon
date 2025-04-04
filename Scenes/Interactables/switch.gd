extends StaticBody2D

class_name Interactable

signal switched_on #sends signal to whatever needs it
signal switched_off

@export var toggleable: bool = true #no need to turn off some switches

var is_switched: bool = false #stores data, eventually pass on to a global or something
var sprite_color: String

func _ready() -> void:
	sprite_color_setter() #calls the function
	if is_switched: #sets up the button on loading (doesn't do anything yet)
		$AnimatedSprite2D.play(sprite_color)
		

func on_interaction(): #called by player, a universal function name for all interactables
	if is_switched and toggleable: #insures it's supposed to be turned back off
		$AnimatedSprite2D.play("off") #turns off animation if on
		is_switched = false #turns off the internal data
		emit_signal("switched_off") #sends the turned off signal
	elif not is_switched: 
		$AnimatedSprite2D.play(sprite_color) #turns on animation if off
		is_switched = true #sets the internal data
		emit_signal("switched_on") #fires off to whatever

func sprite_color_setter(): #sets the color for various switch types based on toggles in editor
	if toggleable: sprite_color = "blue_on"
	if not toggleable: sprite_color = "red_on"
