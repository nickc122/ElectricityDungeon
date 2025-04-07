extends RigidBody2D

@export var active: bool = true

func _physics_process(_delta: float) -> void:
	print($ConductionArea.get_overlapping_areas())
