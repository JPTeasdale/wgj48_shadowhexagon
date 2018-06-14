extends MeshInstance

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const LIGHT_ON_MATERIAL = preload("./WallLightMaterial.tres")
const LIGHT_OFF_MATERIAL = preload("./WallOffMaterial.tres")

enum {ON, OFF}

const state = ON

func _ready():
	off()

func on():
	set_surface_material(0, LIGHT_ON_MATERIAL)
	$DirectionalLight.visible = true
	state = ON

func off():
	set_surface_material(0, LIGHT_OFF_MATERIAL)
	$DirectionalLight.visible = false
	state = OFF

func toggle():
	match state:
		ON:
			off()
		OFF:
			on()