extends Popup

signal button_pressed(id)

func _button_pressed(id):
	emit_signal("button_pressed", id)

func _ready():
	for button in $MarginContainer/VBoxContainer/Controls.get_children():
		button.connect("button_pressed", self, "_button_pressed")

