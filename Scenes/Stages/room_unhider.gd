extends Area2D


func _on_body_entered(body) -> void:
	get_parent().reveal_room()
