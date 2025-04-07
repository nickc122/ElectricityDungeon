extends RigidBody2D

@export var active: bool = false

func _physics_process(_delta: float) -> void:
	if active:
		$AnimatedSprite2D.play("active")
	else: $AnimatedSprite2D.play("off")
