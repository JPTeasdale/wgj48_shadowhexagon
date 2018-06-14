extends KinematicBody

# Constants
var MAX_SPEED = 20
var TURN_SPEED = 0.003
var ROTATION_SPEED = 10
var GRAVITY = Vector3(0, -50, 0)
var FALL_GRAVITY = Vector3(0, -55, 0)
var H_ACCELERATION = 14.0
var H_DECELERATION = 40.0
var SHARP_TURN_THRESHOLD = 140
var JUMP_POWER = 48.0

var cached_wall = 0
func _set_wall_mask(wall):
	if wall != cached_wall:
		cached_wall = wall
		for i in range(1, 4):
			set_collision_mask_bit(i, i == wall)
		
var current_wall = 0
func set_current_wall(wall):
	_set_wall_mask(wall)
	current_wall = wall

# Working Variables
var linear_velocity = Vector3()
func _physics_process(delta):
	var left = -$Camera.global_transform.basis.x 
	var front = -$Camera.global_transform.basis.z
	var up = -GRAVITY.normalized() # (up is against gravity)
	
	left.y=0.0
	front.y=0.0
	
	var movedir = Vector3()
	if Input.is_action_pressed("game_left"):
		movedir += left
	if Input.is_action_pressed("game_right"):
		movedir += -left
	if Input.is_action_pressed("game_front"):
		movedir += front
	if Input.is_action_pressed("game_back"):
		movedir += -front
		
	var attempt_jump = Input.is_action_pressed("game_jump")
	
	var lv = linear_velocity
	
	if up.dot(lv) > 0:
		lv += GRAVITY * delta
	else:
		lv += FALL_GRAVITY * delta
		
	var vv = up.dot(lv) # Vertical velocity
	var hv = lv - up * vv # Horizontal velocity
	
	var hdir = hv.normalized() # Horizontal direction
	var hspeed = hv.length()
	
	var sharp_turn = hspeed > 0.1 and rad2deg(acos(movedir.dot(hdir))) > SHARP_TURN_THRESHOLD
	if movedir.length() > 0.001 and not sharp_turn:
		hdir = movedir
		hspeed = min(hspeed + (H_ACCELERATION * delta), MAX_SPEED)
	else:
		hspeed = max(hspeed - (H_DECELERATION * delta), 0.0)
		
	hv = hdir.normalized() * hspeed
	
	#if $CeilingDetect.is_colliding():
	#	_set_wall_mask(current_wall)
	#else:
	#	_set_wall_mask(0)
		
	if is_on_floor() and attempt_jump:
		vv = JUMP_POWER
		
	lv = hv + up*vv
	linear_velocity = move_and_slide(lv,up)

