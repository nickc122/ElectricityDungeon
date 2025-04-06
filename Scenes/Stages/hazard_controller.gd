extends Node2D

var children #declares a needed variable

func _ready() -> void: 
	children = get_children() #pulls the list of children
	

func hazard_on(): #turns on all child hazards...
	for child in children: #using a for loop to turn the array into a variable...
		child.hazard_on() #and calling the fuction on each

func hazard_off(): #see above
	for child in children:
		child.hazard_off()
