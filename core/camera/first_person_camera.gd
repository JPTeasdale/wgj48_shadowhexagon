extends Camera

export(NodePath) var pivot;

var camera_angle = 0
var camera_change = Vector2()
var cam_pitch_minmax = Vector2(89, -75);
var mouse_sensitivity = 0.3

func _ready():
	pivot = get_node(pivot);
	global_transform = pivot.global_transform
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	if event is InputEventMouseMotion:
		camera_change = event.relative

func _physics_process(delta):
	if camera_change.length():
		pivot.rotate_y(deg2rad(-camera_change.x * mouse_sensitivity))

		var change = -camera_change.y * mouse_sensitivity
		if change + camera_angle < 90 and change + camera_angle > -145:
			rotate_x(deg2rad(change))
			camera_angle += change
		camera_change = Vector2()
