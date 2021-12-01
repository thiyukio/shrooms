extends Control

var inventory = preload("res://Items/Inventory.tres")

func _ready():
	visible = false
	pause_mode = Node.PAUSE_MODE_PROCESS
	update_icons()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		visible = !visible
		get_tree().paused = !get_tree().paused

func update_icons():
	var i = 0
	for slot in $PanelContainer/GridContainer.get_children():
		if inventory.items[i] != null:
			slot.get_child(0).texture = inventory.items[i].texture
		i += 1

func _process(delta):
	update_icons()
