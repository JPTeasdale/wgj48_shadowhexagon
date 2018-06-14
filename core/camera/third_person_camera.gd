extends Camera

export(NodePath) var pivot;

var cam_pitch = 45.0;
var cam_cpitch = 0.0;
var cam_yaw = 0.0;
var cam_cyaw = 0.0;

var cam_radius = 5.0;
var cam_currentradius = 30.0;
var min_cam_radius = 4.0;
var max_cam_radius = 40.0
var cam_pos = Vector3();
var cam_ray_result = {};
var cam_view_sensitivity = 0.3;
var cam_pitch_minmax = Vector2(89, -75);

func _ready():
	pivot = get_node(pivot);
	cam_yaw = rad2deg(pivot.global_transform.basis.get_euler().y - PI)
	cam_cyaw = cam_yaw
	set_process_input(true);
	pass
	
func _input(event):
	if event is InputEventMouseMotion:
		cam_pitch = max(min(cam_pitch+(event.relative.y*cam_view_sensitivity),cam_pitch_minmax.x),cam_pitch_minmax.y);
		cam_yaw = cam_yaw-(event.relative.x*cam_view_sensitivity);
		
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == BUTTON_WHEEL_UP:
				cam_radius = max(min(cam_radius-1,max_cam_radius),min_cam_radius);
			elif event.button_index == BUTTON_WHEEL_DOWN:
				cam_radius = max(min(cam_radius+1,max_cam_radius),min_cam_radius);

func _physics_process(delta):
	if Input.get_connected_joypads().size() > 0:
		var y_axis = Input.get_joy_axis(0, 3) * 5
		var x_axis = Input.get_joy_axis(0, 2) * 5
		cam_pitch = max(min(cam_pitch+(y_axis*cam_view_sensitivity),cam_pitch_minmax.x),cam_pitch_minmax.y);
		cam_yaw = cam_yaw-(y_axis*cam_view_sensitivity);
	
	cam_cpitch = lerp(cam_cpitch, cam_pitch, 10*delta);
	cam_cyaw = lerp(cam_cyaw, cam_yaw, 10*delta);
	
	cam_currentradius = lerp(cam_currentradius, cam_radius, 5*delta);
	
	cam_pos = pivot.global_transform.origin
	
	cam_pos.x += cam_currentradius * sin(deg2rad(cam_cyaw)) * cos(deg2rad(cam_cpitch));
	cam_pos.y = max(3, cam_pos.y + cam_currentradius * sin(deg2rad(cam_cpitch)));
	cam_pos.z += cam_currentradius * cos(deg2rad(cam_cyaw)) * cos(deg2rad(cam_cpitch));
	print(cam_pos)
	
	look_at_from_position(cam_pos, pivot.global_transform.origin, Vector3(0,1,0));
