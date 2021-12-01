extends StaticBody2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed('test'):
		var scene = load("res://Drop.tscn")
		var drop = scene.instance()
		drop.get_node("Sprite").texture = load("res://Items/mush.png")
		add_child(drop)
		
func collected():
	$pick.play()
