extends Polygon2D

var is_visible: bool = true #initiates variable needed in multiple functions
var revealing: bool = false #initiates variable needed in multiple functions
var hiding: bool = false

func _ready() -> void:
	if is_visible: #sets the visibility at the beginning if needed. will eventually require a way to load this info
		modulate.a = 1
	else: modulate.a = 0

func _physics_process(_delta: float) -> void:
	if revealing and modulate.a > 0: #slowly hides the polygon when the visibility changes
		self_modulate.a -= 0.05
	if revealing and modulate.a < 1: #slowly hides the polygon when the visibility changes
		self_modulate.a += 0.05


func reveal_room(): #receives a signal from elsewhere such as a door to hide the polygon
	revealing = true

func hide_room(): #makes the polygon visible again
	hiding = true
