extends CharacterBody2D
class_name Player

@export var speed: float = 100 #sets the speed multiplied by acceleration
@export var acceleration: float = 10 #with speed, sets movement as more fluid and natural


var interactable = null #sets an empty variable because there's nothing to interact with
var in_hazard: int = 0 #how many damaging hazards
var damage: float #declares variable to receive from things that can cause damage
var hazard_timer: float #declares this variable for later (maybe can go back into function but this is fine)

func _ready() -> void:
	$InteractArea.position = Vector2(0,9) #sets the interaction area to match the autoplay down animation
	
func _physics_process(_delta: float) -> void:
	movement() #calls the below function
	if interactable: interact() #calls the below function if there's something to interact with
	move_and_slide() #that mysterious required physics function
		
	
		
func movement():
	var move_vector: Vector2 = Input.get_vector("move_left","move_right","move_up","move_down") #listens to inputs and converts them to a direction
	velocity = velocity.move_toward(move_vector * speed, acceleration) #sets the built-in velocity to gradually increase (move) towards the given number at rate of acceleration

	if velocity.x > 0 and abs(velocity.y) < 45: #checks if moving in a direction and not too much in the other direction before...
		$AnimatedSprite2D.play("walk_right") #switching the animation
		$InteractArea.position = Vector2(7,2)
	elif velocity.x < 0 and abs(velocity.y) < 45: #moves the interaction area on the player
		$AnimatedSprite2D.play("walk_left")
		$InteractArea.position = Vector2(-7,2)
	elif velocity.y > 0 and abs(velocity.x) < 45:
		$AnimatedSprite2D.play("walk_down")
		$InteractArea.position = Vector2(0,9)
	elif velocity.y < 0 and abs(velocity.x) < 45:
		$AnimatedSprite2D.play("walk_up")
		$InteractArea.position = Vector2(0,-8)
	
	elif velocity.x == 0 and velocity.y == (0):
		$AnimatedSprite2D.stop() #stops when the player stops


#region Interaction

func _on_interact_area_body_entered(body: Node2D) -> void:
	if body is Interactable: interactable = body #sets the variable to the encountered body

func _on_interact_area_body_exited(body: Node2D) -> void:
	interactable = null #resets the variable to nothing
	
func interact():
	if Input.is_action_just_pressed("primary_action"): #listens for input and...
		interactable.on_interaction() #calls the general function in the other body
#endregion

#region Damage

#region Hazards (Area2D)
func _on_hitbox_area_area_exited(area: Area2D) -> void:
	in_hazard -= 1 #detects that player left area
	if in_hazard == 0: $HazardTimer.stop() #stops timer if no longer in any hazards
	
func _on_hitbox_area_area_entered(area: Area2D) -> void: #areas on a physics layer called Hazards
	in_hazard += 1 #sets that player is now in a hazard, checks for multiple without repeating damage
	if $HazardTimer.is_stopped(): #only starts if timer isn't already running
		damage = area.player_damage #receives and sets damage from area2D
		hazard_timer = area.hazard_timer #receives the time for how often to damage
		take_damage(damage) #runs the damage function for the first time
		$HazardTimer.start(hazard_timer) #calls and sets the timer bases on how often the hazard should damage
		print(hazard_timer)
		
	
func _on_hazard_timer_timeout() -> void:
	if in_hazard > 0: #checks that player is still on a hazard
		take_damage(damage) #when the timer finishes damages player again if still in area
	
#endregion
	
#region Enemies (Body2D)

func _on_hitbox_area_body_entered(body: Node2D) -> void: #when encountering enemy
	if $InvincibilityTimer.is_stopped(): #makes sure there hasn't been a recent hit
		damage = body.player_damage #identifies damage from enemy
		take_damage(damage) #takes damage
		$InvincibilityTimer.start() #starts brief invincibility

#endregion


func take_damage(damage): #a function to handle all damage
	Global.player_current_hp -= damage #takes damage from whatever and applies it to HP
	print(Global.player_current_hp)

#endregion
