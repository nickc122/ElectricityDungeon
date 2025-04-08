extends RigidBody2D

var active: bool = false #all blocks start as inactive, not with electricity

@onready var conduction_area = $ConductionArea #initializes its own conduction points so it doesn't repeat every frame
@onready var animation = $AnimatedSprite2D

@export var animated: bool = true

var check_conduction: Array #declares an array to hold neighboring conductives
var frame_skip: bool = false #creates a needed variable allow process to only run every other fram to clear data
var animation_frame #gets animation frame from other block when activating
var animation_progress #gets the progress through the frame


func _physics_process(_delta: float) -> void:
	active = false #initially resets all non-powered conductives to inactive
	frame_skip = !frame_skip #works with below if statement to...
	if(frame_skip): #create a refresh frame for all blocks. Necessary?
		check_conduction = conduction_area.get_overlapping_areas() #checks for conductives in all neighboring spaces
		for node in check_conduction: #starts to check all neighbors for conduction
			if node.active: #looks at the specific active variable in neighbors and runs if active
				if not conduction_area.active:
					animation_frame = node.get_animation_frame()
				active = true #sets its own active to true
				break #ends here before finding any falses
			else: active = false #sets own active to false if no active neighbors
		if active: #if it set itself to active
			animation.play("active") #animates
			conduction_area.active = true #sets its own child detector to active, which doesn't get reset each frame. ESSENTIAL!(?) 
		else: animation.play("off") #off animation if no electricity=

#In the if node.active block, add a "if not conduction_area.active" to check if it is about to become active to avoid wasted resources.
#Within it, call a function (that needs to be added) in the other conduction area (stored in node) that gets the current animation frame progress...
#via get_parent.animatedsprite.frame_progress and passes it back to sync the 5animations. 
