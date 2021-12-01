extends "res://characters/enemy/states/enemy_state.gd"

onready var player = get_node("/root/Game/YSort/Player")

export var steer_force = 0.1
export var num_rays = 16
export var max_speed = 200
export var detection_radius = 300
export var look_ahead = 70

var ray_directions = []
var interest = []
var danger = []

var rotation
var velocity = Vector2.ZERO
var desired_velocity = Vector2.ZERO
var chosen_dir = Vector2.ZERO


func _ready():
	interest.resize(num_rays)
	danger.resize(num_rays)
	ray_directions.resize(num_rays)
	for i in num_rays:
		var angle = i * 2 * PI / num_rays
		ray_directions[i] = Vector2.RIGHT.rotated(angle)

func update(delta):
	rotation = velocity.angle()
	set_interest()
	set_danger()
	choose_direction()
	desired_velocity = chosen_dir.rotated(rotation) * max_speed
	velocity = velocity.linear_interpolate(desired_velocity, steer_force)
	owner.move_and_slide(velocity)
	if velocity.x > 0:
		owner.sprite.flip_h = false
	else:
		owner.sprite.flip_h = true
	#owner.rotation = rotation + PI/2

func detect_player():
	return (owner.position - player.position).length() < detection_radius

func set_interest():
	for i in num_rays:
		interest[i] = 0
	if(detect_player()):
		for i in num_rays:
			interest[i] = (player.position - owner.position).normalized().dot(ray_directions[i].rotated(rotation))


func set_danger():
	var space_state = owner.get_world_2d().direct_space_state
	for i in num_rays:
		var result = space_state.intersect_ray(owner.position,
				owner.position + ray_directions[i].rotated(rotation) * look_ahead,
				[self, owner, player])
		#var ray_dist = result.position - owner.position
		danger[i] = (-(result.position - owner.position).length()/look_ahead) + 1 if result else 0.0

func choose_direction():

	for i in num_rays:
		if danger[i] > 0.0:
			interest[i] -= 3*danger[i]
	chosen_dir = Vector2.ZERO
	for i in num_rays:
		chosen_dir += ray_directions[i] * interest[i]
	chosen_dir = chosen_dir.normalized()

