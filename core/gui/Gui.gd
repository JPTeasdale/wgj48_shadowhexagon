extends Control

onready var options = [
	$MarginContainer/VBoxContainer/HBoxContainer/Option1,
	$MarginContainer/VBoxContainer/HBoxContainer/Option2,
	$MarginContainer/VBoxContainer/HBoxContainer/Option3,
]

func set_num_options(num):
	$MarginContainer/VBoxContainer/HBoxContainer/CenterContainer.visible = true
	for i in range(0, num-1):
		options[i].visible = true
		
func set_frozen(b):
	$MarginContainer/VBoxContainer/Frozen.visible = b
	
