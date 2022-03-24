extends MarginContainer
var dialogNum = 0
var dialog = [
	'Hello there, this tutorial is awesome.',
	'If you like what you see, you can click the subscribe button',
	'and if you don\'t you shoud do it anyway!'
]

	

var dialog_index = 0
var finished = false

func _ready():
	if (dialogNum == 1):
		dialog = [ "Maybe","It seems you're a bit confused. Let me elaborate further.", ""]
	
	load_dialog()

func _process(delta):
	$"next-indicator".visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		load_dialog()

func load_dialog():
	if dialog_index < dialog.size():
		finished = false
		$RichTextLabel.bbcode_text = dialog[dialog_index]
		$RichTextLabel.percent_visible = 0
		$Tween.interpolate_property(
			$RichTextLabel, "percent_visible", 0, 1, 1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		$Tween.start()
		
	else:
		queue_free()
	dialog_index += 1


func _on_Tween_tween_completed(object, key):
	finished = true
