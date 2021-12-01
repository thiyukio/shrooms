extends Entity

onready var hit = $Sprite.material.get_shader_param('hit')
var smoke = preload("res://Smoke.tscn")
var state_machine 
var knock = 400
var last_dir
var velocity = Vector2(0,0)
var immune = false

export var speed  = 60

func _ready():
	state_machine = $AnimationTree.get("parameters/playback")
	hp = 50

func _process(delta):
	velocity = Vector2.ZERO
	state_machine.travel("idle")
	if Input.is_action_pressed('down'):
		velocity.y += 1
		run()
	if Input.is_action_pressed('left'):
		$Sprite.flip_h = false
		velocity.x += -1
		run()
	if Input.is_action_pressed('up'):
		velocity.y += -1
		run()
	if Input.is_action_pressed('right'):
		velocity.x += 1
		run()
		$Sprite.flip_h = true
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		move_and_slide(velocity)
	else:
		idle()

func idle():
	state_machine.travel("idle")
	$steps.playing = false


func run():
	state_machine.travel("run")
	if $steps.playing == false:
		$steps.play()

func knockback(dir):
	velocity = dir*knock
	var tween = get_node('Tween')
	tween.interpolate_property(self, "position", self.position, move_and_slide(velocity)*self.get_process_delta_time() + self.position, 0.1, Tween.EASE_OUT) 
	tween.start()
	blink()
	
func blink():
	hit = true
	immune = true
	$Sprite.material.set_shader_param('hit', hit)
	yield(get_tree().create_timer(0.1), "timeout")
	hit = false
	$Sprite.material.set_shader_param('hit', hit)
	yield(get_tree().create_timer(0.5), "timeout")
	immune = false





#func _input(event):
#	if event.is_action_pressed("test"):
#		var smoke_instance = (smoke.instance())
#		smoke_instance.position = position
#		get_parent().add_child(smoke_instance)
