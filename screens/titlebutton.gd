tool
extends Control

export(String) var text

signal button_pressed(id)

func hover():
	$Label.add_color_override("font_color", Color(1,0,0))

func reset():
	$Label.add_color_override("font_color", Color(1,1,1))

func gui_input(e):
	if e is InputEventMouseButton and e.pressed:
		emit_signal("button_pressed", text)

func _ready():
	$Label.text = text.to_upper()
	$Label.connect("mouse_entered", self, "hover")
	$Label.connect("mouse_exited", self, "reset")
	$Label.connect("gui_input", self, "gui_input")
