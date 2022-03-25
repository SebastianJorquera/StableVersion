extends Area2D

var item_name
var active = false

#part of changing scene
#export(PackedScene) var target_scene

func _ready():
	connect("body_entered", self, '_on_NPC_body_entered')
	connect("body_exited", self, '_on_NPC_body_exited')
	
	
func _process(delta):
	$KeyInput.visible = active
	

func _input(event):
	if get_node_or_null('DialogNode') == null:
		if event.is_action_pressed('ui_interact') && active:
			get_tree().paused = true
			var dialog = Dialogic.start('timeline-1')
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			item_name = "Proposition#1"
			PlayerInventory.add_item(item_name,1)
			add_child(dialog)
			dialog.connect('timeline_end', self, 'unpause' )
			#part of changeing scene
#			dialog.connect('timeline_end', self, 'next_level')
			
			

func unpause(timeline_name):
	get_tree().paused = false

func _on_NPC_body_entered(body):
	if body.name == 'Player':
		active = true


func _on_NPC_body_exited(body):
	if body.name == 'Player':
		active = false
	

#part of changeing scene
#func next_level(timeline_name):
#	get_tree().change_scene_to(target_scene)
