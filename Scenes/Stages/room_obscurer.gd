extends Polygon2D

var is_visible: bool = true #initiates variable needed in multiple functions
var hiding: bool = false #initiates variable needed in multiple functions

func _ready() -> void:
	if is_visible: #sets the visibility at the beginning if needed. will eventually require a way to load this info
		visible = true
	else: visible = false

func _physics_process(_delta: float) -> void:
	if hiding and modulate.a > 0: #slowly hides the polygon when the visibility changes
		self_modulate.a -= 0.05
		print(modulate.a)

func make_invisible(): #receives a signal from elsewhere such as a door
	if visible:
		hiding = true
