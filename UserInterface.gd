extends CanvasLayer


func _ready():
	$Inventory.visible = false

func _input(event):
	if event.is_action_pressed("inventory") && !$PauseMenu.visible:
		openInventory()
	if event.is_action_pressed("pause") && !$Inventory.visible:
		openPauseMenu()
		
		
func openInventory():
	$Inventory.visible = !$Inventory.visible
	$Inventory.initialize_inventory()
	get_tree().paused = !get_tree().paused
	
func openPauseMenu():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	$PauseMenu.visible = new_pause_state


func _on_Resume_pressed():
	openPauseMenu()


func _on_Quit_pressed():
	get_tree().quit()

func _on_Inventory_pressed():
	openPauseMenu()
	openInventory()
