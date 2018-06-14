extends Spatial

signal closed

func _ready():
	$AnimationPlayer.connect("animation_finished", self, "animation_finished")

func animation_finished(name):
	match name:
		"open":
			$AnimationPlayer.play("close")
		"close":
			emit_signal("closed")
		

func open():
	$AnimationPlayer.play("open")

	