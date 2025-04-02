extends StaticBody2D

signal unobscure_room

var is_opened: bool = false


func _ready() -> void:
	%Door1.unobscure_room.connect(func():
		%RoomObscurer1.make_invisible())
	if not is_opened: #checks whether door has previously been opened and sets appropriate status
		$AnimatedSprite2D.visible = true
		$CollisionShape2D.disabled = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("debug_button"): #a stand-in to test this
		open_door()

func open_door():
	z_index = 101 #moves door above room obscurer
	$AnimationPlayer.play("opening") #plays the sliding up animation
	$CollisionShape2D.disabled = true #remove collision. Maybe just queue_free the door? I'll probably want it to hold info though.
	emit_signal("unobscure_room") #sends signal to specific room_obscurer
