extends CanvasLayer
var dialogLevel = 1
#This will allow us to produce different dialogue depending on the level.
#Since we're starting off with the first dialogue, pressing the contradicting statement will lead to the response container 
#to be filled with the statement that was on the button the player pressed. This leads to the enemy to then respond to it. 
#The dialogLevel will increase. The enemy dialogue will refelect the next level and the buttons will reflect that enemy dialouge.
#It will keeps going untill we reach the last dialogue. Time: 11:42PM 3-8-22  
export(String,FILE,"*.json") var dialogue1 

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_argueBTN_pressed():
	#get_tree().change_scene("DialogOptions.tscn")
	$ArgueOrProposition.visible = false
	$DialogOptionsContainer.visible = true

func _on_yesBTN_pressed():
	$DialogOptionsContainer.visible = false
	$Response.visible = true
	
	pass # Replace with function body.

func appendLevel():
	dialogLevel+=1 #Increases the level of the dialogue. For every level, the dialogue will advance.

func visibilityUI():
	$ArgueOrProposition.visible = true

func getLevel():
	return dialogLevel
	print(dialogLevel)





#func load_dialogue(int check){ }

