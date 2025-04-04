extends Area2D

@export var delay_timer: bool = false #delay after flipping switch

var player_damage: float = 0 #how much damage it does to the player
var hazard_timer: float = 2 #how long before it does damage again


func hazard_on():
	if delay_timer: await get_tree().create_timer(0.3).timeout #if it should delay after the switch then delay
	$AnimatedSprite2D.play("spiky") #change sprite
	player_damage = 1 #set damage when active
	
func hazard_off():
	if delay_timer: await get_tree().create_timer(0.3).timeout 
	$AnimatedSprite2D.play("safe")
	player_damage = 0 #resets damage now that safe
