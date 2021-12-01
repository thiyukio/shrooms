extends Label


func _ready():
	pass # Replace with function body.

func _process(_delta):
	text = String(get_node("/root/Game/YSort/Player").hp)
