extends Control

onready var options = [
	$MarginContainer/HBoxContainer/Option1,
	$MarginContainer/HBoxContainer/Option2,
	$MarginContainer/HBoxContainer/Option3,
]

func set_num_options(num):
	$MarginContainer/HBoxContainer/CenterContainer.visible = true
	for i in range(0, num-1):
		options[i].visible = true
