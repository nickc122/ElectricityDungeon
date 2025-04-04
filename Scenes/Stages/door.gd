extends StaticBody2D

var is_opened: bool = false


func _ready() -> void:
	if not is_opened: #checks whether door has previously been opened and sets appropriate status
		$AnimatedSprite2D.visible = true
		$CollisionShape2D.disabled = false



func open_door():
	if not is_opened:
		z_index = 101 #moves door above room obscurer
		$AnimationPlayer.play("opening") #plays the sliding up animation
		$CollisionShape2D.disabled = true #remove collision. Maybe just queue_free the door? I'll probably want it to hold info though.
		is_opened = true #stores that the door is opened
