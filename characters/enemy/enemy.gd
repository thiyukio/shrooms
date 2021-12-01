extends Entity

onready var sprite = get_node("Sprite")
onready var current_state = get_node('States/Seek')

export var speed = 200

func _physics_process(delta):
	current_state.update(delta)
	if Input.is_action_just_pressed('test'):
		if current_state.name == 'Seek':
			current_state = get_node('States/Flee')
		else:
			current_state = get_node('States/Seek')
		current_state.enter()






# export var max_speed = 30
# var point
# var vel = Vector2(randf(),randf())
# var spawn_point = Vector2()
# var state = {}

func _ready():
	current_state.max_speed = speed
	# spawn_point = position
	$Area2D.connect("body_entered", self, "damage")
	$Area2D.monitoring = true

# func _physics_process(delta):
# 	move_and_slide(vel*30)


# func wander():
# 	randomize()
# 	var noise = OpenSimplexNoise.new()
# 	noise.seed = randi()
# 	noise.octaves = 4
# 	noise.period = 20.0
# 	noise.persistence = 0.8
# 	vel = vel.rotated((noise.get_noise_1d(1)))
# 	var distance  = position - spawn_point
# 	if distance.length() > 50 and vel.dot(distance) > 0:
# 		vel -= distance.normalized()*(distance.length() - 50) / 20
# 		vel = vel.normalized()
# 		print('debug')


func damage(node):
	if node.name == 'Player' and node.immune == false:
		var dir = (node.global_position - global_position).normalized()
		node.knockback(dir)
		node.hp -= 1
		print(node.hp)
	else:
		#vel = -vel.rotated(randf()*PI)
		pass
