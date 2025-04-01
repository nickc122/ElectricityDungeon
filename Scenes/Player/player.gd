extends CharacterBody2D
class_name Player

@export var speed: float = 100 #sets the speed multiplied by acceleration
@export var acceleration: float = 10 #with speed, sets movement as more fluid and natural

func _ready() -> void:
	pass
	
func _physics_process(_delta: float) -> void:
	movement() #calls the below function
	move_and_slide() #that mysterious required physics function
	
func movement():
	var move_vector: Vector2 = Input.get_vector("move_left","move_right","move_up","move_down") #listens to inputs and converts them to a direction
	velocity = velocity.move_toward(move_vector * speed, acceleration) #sets the built-in velocity to gradually increase (move) towards the given number at rate of acceleration

	if velocity.x > 0 and abs(velocity.y) < 45: #checks if moving in a direction and not too much in the other direction before...
		$AnimatedSprite2D.play("walk_right") #switching the animation
#		$InteractArea2D.position = Vector2(6, 2) #a save-for-later from the tutorial to move the interact zone
	elif velocity.x < 0 and abs(velocity.y) < 45:
		$AnimatedSprite2D.play("walk_left")
#		$InteractArea2D.position = Vector2(-6, 2)
	elif velocity.y > 0 and abs(velocity.x) < 45:
		$AnimatedSprite2D.play("walk_down")
#		$InteractArea2D.position = Vector2(0, 8)
	elif velocity.y < 0 and abs(velocity.x) < 45:
		$AnimatedSprite2D.play("walk_up")
#		$InteractArea2D.position = Vector2(0, -6)
	
	elif abs(velocity.x) == (0) and abs(velocity.y) == (0):
		$AnimatedSprite2D.stop() #stops when the player stops
