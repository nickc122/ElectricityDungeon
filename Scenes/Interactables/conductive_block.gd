extends RigidBody2D

var active: bool = false #all blocks start as inactive, not with electricity

@onready var conduction_area = $ConductionArea #initializes its own conduction points so it doesn't repeat every frame

var check_conduction: Array #declares an array to hold neighboring conductives
var frame_skip: bool = false #creates a needed variable allow process to only run every other fram to clear data


func _physics_process(_delta: float) -> void:
	active = false #initially resets all non-powered conductives to inactive
	frame_skip = !frame_skip #works with below if statement to...
	if(frame_skip): #create a refresh frame for all blocks. Necessary?
		check_conduction = conduction_area.get_overlapping_areas() #checks for conductives in all neighboring spaces
		for node in check_conduction: #starts to check all neighbors for conduction
			if node.active: #looks at the specific active variable in neighbors and runs if active
				active = true #sets its own active to true
				break #ends here before finding any falses
			else: active = false #sets own active to false if no active neighbors
		if active: #if it set itself to active
			$AnimatedSprite2D.play("active") #animates
			conduction_area.active = true #sets its own child detector to active, which doesn't get reset each frame. ESSENTIAL!(?) 
		else: $AnimatedSprite2D.play("off") #off animation if no electricity
	
	
