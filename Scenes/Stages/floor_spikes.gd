extends Area2D

@export var delay_timer: bool = false #delay after flipping switch
@export var hazard_timer: float = 0.7 #how long before it does damage again

var player_damage: float = 0 #actual damage done to player, starts as safe by default
@export var how_much_damage: float = 1 #how bad it will hurt the plaer

func hazard_on():
	if delay_timer: await get_tree().create_timer(0.3).timeout #if it should delay after the switch then delay
	$AnimatedSprite2D.play("spiky") #change sprite
	player_damage = how_much_damage #set damage when active
	
func hazard_off():
	if delay_timer: await get_tree().create_timer(0.3).timeout 
	$AnimatedSprite2D.play("safe")
	player_damage = 0 #resets damage now that safe
