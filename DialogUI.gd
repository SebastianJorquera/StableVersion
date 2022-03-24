extends CanvasLayer
var dialogLevel = 1
var PressingOptions = 0;
#This will allow us to produce different dialogue depending on the level.
#Since we're starting off with the first dialogue, pressing the contradicting statement will lead to the response container 
#to be filled with the statement that was on the button the player pressed. This leads to the enemy to then respond to it. 
#The dialogLevel will increase. The enemy dialogue will reflect the next level and the buttons will reflect that enemy dialouge.
#It will keeps going untill we reach the last dialogue. Time: 11:42PM 3-8-22  
export(String,FILE,"*.json") var dialogue1 
onready var timer = get_node("Timer")
onready var maybe_button = get_node("DialogOptionsContainer/Panel/MarginContainer/Panel/HBoxContainer/maybeBTN")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#var timer = get_node("Timer")
	#timer.set_wait_time(1)
	#button.connect("pressed",self,"_on_maybeBTN_pressed")
	#timer.connect("timeout", self,"_on_Timer_timeout")

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_argueBTN_pressed():
	$DialogOptionsContainer.visible = true
	if (PressingOptions == 1): 
		get_node("DialogOptionsContainer/Panel/MarginContainer/Panel/HBoxContainer/yesBTN").visible = false
		get_node("DialogOptionsContainer/Panel/MarginContainer/Panel/HBoxContainer/maybeBTN").visible = false
		get_node("DialogOptionsContainer/Panel/MarginContainer/Panel/HBoxContainer2/noBTN").visible = false
		get_node("DialogOptionsContainer/Panel/MarginContainer/Panel/HBoxContainer2/elipsBTN").visible = false
		get_node("DialogOptionsContainer/Panel/MarginContainer/Panel/HBoxContainer/Really,now?BTN").visible = true
		get_node("DialogOptionsContainer/Panel/MarginContainer/Panel/HBoxContainer/StillConfusedBTN").visible = true
		get_node("DialogOptionsContainer/Panel/MarginContainer/Panel/HBoxContainer2/couldnotsayBTN").visible = true
		get_node("DialogOptionsContainer/Panel/MarginContainer/Panel/HBoxContainer2/elips2BTN").visible = true


#DialogOptionsContainer 1 -- Begin
func _on_yesBTN_pressed():
	#$DialogOptionsContainer.visible = false

	get_node("Response/Panel/MarginContainer/RichTextLabel").dialogPicked= "Yes"
	$Response.visible = true
	
func _on_ResponseBTN_pressed(): #This button will be on the Response textbox, open after the last dialogue.

	$Response.visible = false #At the end of the textbox this button 
	#will be pressed and will turn off the response's visibility to show the ArgueOrProposition box.
	#$DialogOptionsContainer.visible = false
	get_node("Response/Panel/MarginContainer/RichTextLabel/ResponseBTN").visible = false #In case the player picks this button again, the dialogue will repeat. 
	#This will turn off the response button visibility and have the text appear again.
	#get_node("Response/Panel/MarginContainer/RichTextLabel").page = -2

func _on_noBTN_pressed():
	$ResponseNo.visible = true

func _on_ResponseNoBTN_pressed():
	$ResponseNo.visible = false
	#Changing enemy dialog to reflect the new buttons and vice versa.
	$DialogOptionsContainer.visible = false
	$DialogOptionsContainer2.visible = true
	get_node("Enemy/EnemyDialogue/MarginContainer/HBoxContainer/EnemyText").text = "This is supposed to be a test of the combat system. This textbox indicates that you've advanced to the next dialogue. The Buttons will also change to reflect the dialogue's advancement."
	pass # Replace with function body.
func _on_maybeBTN_pressed():
	#get_node("Response/Panel/MarginContainer/RichTextLabel").page = -2
	#get_node("Response/Panel/MarginContainer/RichTextLabel").dialog[0] = ["Maybe"]

	#get_node("Response/Panel/MarginContainer/RichTextLabel").dialog = ["Maybe","What do you mean by that?","I mean maybe","You mean wrong.",""]
	get_node("Response/Panel/MarginContainer/RichTextLabel").dialogPicked = "Maybe"
	$Response.visible = true
	#$ResponseMaybe.visible = true
	pass # Replace with function body.
	
func _on_ResponseMaybeBTN_pressed():
	$ResponseMaybe.visible = false
	get_node("DialogOptionsContainer").visible = false
	$ArgueOrProposition.visible = true
	PressingOptions+=1
	get_node("Enemy/EnemyDialogue/MarginContainer/HBoxContainer/EnemyText").text = "I'm downloaded off a sprite sheet. We are not original sprites."
	
	pass # Replace with function body.	
	
func _on_ReallynowBTN_pressed():
	
	pass # Replace with function body.

func _on_ResponseReallyNowBTN_pressed():
	pass # Replace with function body.



func _on_elipsBTN_pressed():
	pass # Replace with function body.
#DialogOptionsContainer 1 --End



func appendLevel():
	dialogLevel+=1 #Increases the level of the dialogue. For every level, the dialogue will advance.

func visibilityUI():
	$ArgueOrProposition.visible = true

func getLevel():
	return dialogLevel
	print(dialogLevel)





func _on_Timer_timeout():
	$Response.visible = true
	
	#get_node("Enemy/EnemyDialogue/MarginContainer/HBoxContainer/EnemyText").text = "I'm downloaded off a sprite sheet. We are not original sprites."
	pass # Replace with function body.





