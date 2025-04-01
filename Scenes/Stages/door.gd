extends StaticBody2D

signal unobscure_room

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("debug_button"):
		open_door()

func open_door():
	visible = false
	$CollisionShape2D.disabled = true
	emit_signal("unobscure_room")
