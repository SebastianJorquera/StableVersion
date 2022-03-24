extends RichTextLabel
var dialogTag

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var dialog = [
	"Yes",
	"Well, that's just unforunate.",
	""]
var  dialogPicked ="Yes"
var dialogDict = {
	"Yes": ["Yes","Well, that's just unfortunate.", ""],
	"Maybe": ["Maybe","We should have it more like this.", ""]

}


var page = -2#This is in in negative 2 in order to give a longer time for the picked response to remain.


# Called when the node enters the scene tree for the first time.
func _ready():

#	print(node3) #Checking if object is null
	match dialogTag:
			"Maybe":
				dialog = ["Maybe","It seems you're a bit confused. Let me elaborate further.", ""]
			
			"Yes":
				dialog =  ["Yes","Well, that's just unforunate.",""]
	set_process_input(true)
	set_bbcode(dialogDict[dialogPicked][page])
	set_visible_characters(0)
	
	pass # Replace with function body.
	

 
	
func _input(event):
	match dialogTag:
		"Maybe":
			dialog = ["Maybe","It seems you're a bit confused. Let me elaborate further.", ""]
			
		"Yes":
			dialog =  ["Yes","Well, that's just unforunate.",""]
	if event is InputEventMouseButton and event.pressed:
		if get_visible_characters() > get_total_character_count():
			if page < dialogDict[dialogPicked].size()-1: 
				page += 1
				set_bbcode(dialogDict[dialogPicked][page])
				set_visible_characters(0)
			if page+1 > dialogDict[dialogPicked].size()-1: #The very last dialog will be filler that's intended to be skipped over. Once it's skipped, the dialog box will be closed
				
				$ResponseBTN.visible = true
				page = -1
				
		else:
			set_visible_characters(get_total_character_count())
	
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():

	set_visible_characters(get_visible_characters()+1)
	pass # Replace with function body.



