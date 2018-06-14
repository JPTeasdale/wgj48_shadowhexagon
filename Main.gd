extends Node

onready var Room = load("res://levels/Room.tscn")

var current_room
var pause_screen

func play():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	var root = get_tree().root
	if current_room:
		root.remove_child(current_room)
		current_room.call_deferred("free")
		
	var room = Room.instance()
	room.connect("win", self, "win") 
	root.add_child(room)
	current_room = room
	$TitleCard.hide()
	$PauseScreen.hide()
	$WinScreen.hide()
	get_tree().paused = false

func _ready():
	$TitleCard.connect("button_pressed", self, "button_pressed")
	$PauseScreen.connect("button_pressed", self, "button_pressed")
	$WinScreen.connect("button_pressed", self, "button_pressed")
	$TitleCard.popup()
	
func pause():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$PauseScreen.popup()
	get_tree().paused = true
	for c in get_tree().root.get_children():
		print(c.name)
	
func win():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$WinScreen.popup()
	get_tree().paused = true
	
func resume():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
	$PauseScreen.hide()
	
func quit():
	get_tree().quit()
	
func button_pressed(button):
	match button:
		"play", "restart":
			play()
		"quit":
			quit()
		"resume": 
			resume()
		_:
			print("Unhandled Button: ", button)

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		pause()
		