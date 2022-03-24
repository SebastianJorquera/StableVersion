extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var dialog = [
	"...",
	"Your response is not a surprising one. But, it's rude to be silent.",
	""]

var page = -2 #This is in in negative 2 in order to give a longer time for the picked response to remain.


# Called when the node enters the scene tree for the first time.
func _ready():
	
#	print(node3) #Checking if object is null
	set_process_input(true)
	set_bbcode(dialog[page])
	set_visible_characters(0)
	pass # Replace with function body.
	

 
	
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if get_visible_characters() > get_total_character_count():
			if page < dialog.size()-1: 
				page += 1
				set_bbcode(dialog[page])
				set_visible_characters(0)
			if page+1 > dialog.size()-1: #The very last dialog will be filler that's intended to be skipped over. Once it's skipped, the dialog box will be closed
				
				#$ResponseNoBTN.visible = true
				page = -2
				
		else:
			set_visible_characters(get_total_character_count())
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	set_visible_characters(get_visible_characters()+1)
	pass # Replace with function body.



