extends Spatial

enum {OFF, WALL_1, WALL_2, WALL_3}

signal win

var wall_options = 1;
var current_wall = 0;

var is_closed = false
var is_escaped = false

onready var light_walls = [$LightWall1, $LightWall2, $LightWall3] 
onready var pickups = [$Pickup, $Pickup2, $Pickup3] 

func toggle_wall():
	current_wall = (current_wall + 1) % wall_options
	$Player.set_current_wall(current_wall)
	
	for wall in light_walls:
		if String(current_wall) in wall.name:
			wall.on()
		else:
			wall.off()
			
func on_pickup():
	wall_options+=1
	$GUI.set_num_options(wall_options)
	if wall_options > 3:
		$RoofSwitch.activate()
		
func check_win():
	if is_closed and is_escaped:
		emit_signal("win")
		
func open_roof():
	is_closed = false
	$Roof.open()
	
func on_roof_closed():
	is_closed = true
	check_win()
	
func on_body_entered_winbox(body):
	if "Player" in body.name:
		is_escaped = true
		check_win()
		
func on_body_exited_winbox(body):
	if "Player" in body.name:
		is_escaped = false

func _ready():
	for pickup in pickups:
		pickup.connect("collected", self, "on_pickup")
		
	for wall in light_walls:
		wall.off()
	$Player.connect("is_frozen", $GUI, "set_frozen")
	
	$RoofSwitch.connect("pressed", self, "open_roof")
	$Roof.connect("closed", self, "on_roof_closed")
	$WinBox.connect("body_entered", self, "on_body_entered_winbox")
	$WinBox.connect("body_exited", self, "on_body_exited_winbox")

func _process(delta):
	if Input.is_action_just_pressed("game_light"):
		toggle_wall()
