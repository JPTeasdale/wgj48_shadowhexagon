extends Control

signal restart
signal resume

func _restart():
	emit_signal("restart")
	
func _resume():
	emit_signal("resume")
	

func _ready():
	$MarginContainer/VBoxContainer/Controls/Restart.connect("pressed", self, "_restart")
	$MarginContainer/VBoxContainer/Controls/Resume.connect("pressed", self, "_resume")

