extends RigidBody2D

var inventory = preload("res://Items/Inventory.tres")
var mush = preload("res://Items/mush.tres")

signal collected

var time = 0
var speed = 50
var decay = 2
var dir
var vel = Vector2(0,0)
func _ready():
	self.connect("collected", get_parent(), "collected")
#	$Area2D.connect("body_entered", self, "attract")
	randomize()
	decay += 6*randf()
	dir = Vector2(rand_range(-1,1), rand_range(-1,1))
	#print(dir)
	set_axis_velocity(dir*500)


#func _process(delta):
#	if Input.is_action_just_pressed("test"):
#		inventory.set_item(inventory.find_index(),mush)
#		print(inventory.items)
#	if Input.is_action_just_released("test"):
#		print(inventory.find_index())

func _physics_process(delta):
	for body in $Area2D.get_overlapping_bodies():
		if body.name == "Player":
			dir = (body.global_position - global_position + Vector2.UP*8)
			vel = 80*dir/global_position.distance_to(body.global_position + Vector2.UP*8)
			if dir.length() <= 8:
				inventory.set_item(inventory.find_index(), mush)
				print(inventory.items)
				emit_signal("collected")
				queue_free()
	position += vel*delta
#
#func attract(node):
#	if node.name == 'Player':
#		var dir = node.global_position - global_position
#		apply_central_impulse(dir*20)
