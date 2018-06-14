extends Control

signal pressed

func hover():
	$Label.add_color_override("font_color", Color(1,0,0))

func reset():
	$Label.add_color_override("font_color", Color(1,1,1))
	
func gui_input(e):
	if e is InputEventMouseButton:
		emit_signal("pressed")

func _ready():
	$Label.connect("mouse_entered", self, "hover")
	$Label.connect("mouse_exited", self, "reset")
	$Label.connect("gui_input", self, "gui_input")
