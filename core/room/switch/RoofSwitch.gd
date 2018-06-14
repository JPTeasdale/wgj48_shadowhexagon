extends Spatial

signal pressed

const DEACTIVATE_MATERIAL = preload("./RoofSwitchOff.tres")
const ACTIVATE_MATERIAL = preload("./RoofSwitchOn.tres")

func activate():
	$MeshInstance.set_surface_material(0, ACTIVATE_MATERIAL)
	$Switch.connect("body_entered", self, "body_entered")
	
func body_entered(body):
	if "Player" in body.name:
		emit_signal("pressed")
