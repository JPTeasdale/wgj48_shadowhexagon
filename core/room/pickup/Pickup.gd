extends Spatial

signal collected

func on_body_entered(body):
	if "Player" in body.name:
		emit_signal("collected")
		queue_free()

func _ready():
	$Area.connect("body_entered", self, "on_body_entered")

func _process(delta):
	self.rotate_y(delta)
