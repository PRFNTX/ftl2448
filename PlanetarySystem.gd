extends Spatial

var ref
var star_instance = load("res://StarView.tscn")
var planet_instance = load("res://PlanetView.tscn")
var star_new = load("res://Star.tscn")
var center
var planets = {
	
}
var planet_times = {
}

var lights = {
	"O": load("res://Lighting/Blue.tscn"),
	"B": load("res://Lighting/White-Blue.tscn"),
	"A": load("res://Lighting/White.tscn"),
	"F": load("res://Lighting/Yellow-white.tscn"),
	"G": load("res://Lighting/Yellow.tscn"),
	"K": load("res://Lighting/Orange.tscn"),
	"M": load("res://Lighting/Red.tscn"),
	"N": load("res://Lighting/Dark.tscn")
}
var materials = {
	"O": load("res://BlueStar.tres"),
	"B": load("res://WhiteBlueStar.tres"),
	"A": load("res://WhiteStar.tres"),
	"F": load("res://Yellow-White.tres"),
	"G": load("res://YellowStar.tres"),
	"K": load("res://OrangeStar.tres"),
	"M": load("res://RedStar.tres"),
	"N": load("res://DarkStar.tres")
}

func _ready():
	set_process_input(true)

func init():
	var central_star = ref
	center = star_instance.instance()
	var star_material = materials[ref.spectral_class.spectral]
	var star_light = lights[ref.spectral_class.spectral].instance()
	center.get_node("Mesh").set_material_override(star_material)
	center.add_child(star_light)
	$system_gimbal/system.add_child(center)
	print(ref.read_star_size_num())
	center.transform.basis.x = Vector3(float(ref.read_star_size_num()), 0, 0)
	center.transform.basis.y = Vector3(0, float(ref.read_star_size_num()), 0)
	center.transform.basis.z = Vector3(0,0,float(ref.read_star_size_num()))
	$camera_gimbal/camera.size = 3.5*ref.planetary_slots.total
	for star in ref.planets.size():
		if ref.planet_slots[star] != 0:
			planets[ref.planets[star]] = planet_instance.instance()
			$system_gimbal/system.add_child(planets[ref.planets[star]])
			var t = rand_range(1, 10000)
			if ref.planet_slots[star] > 0:
				var period = 1/float(ref.planet_slots[star])
				var p_x = float((ref.planet_slots[star] +2))*cos((t*2*3.14)/period)
				var p_z = float((ref.planet_slots[star] +2))*sin((t*2*3.14)/period)
				planets[ref.planets[star]].translation.x = p_x
				planets[ref.planets[star]].translation.z = p_z
			else:
				planets[ref.planets[star]].translation.x = (ref.planet_slots[star])
	create_zones()
	print(ref.planets.size())

func create_zones():
	var size_A = ref.planetary_slots.A + 2
	var size_B = size_A + ref.planetary_slots.B
	var size_C = size_B + ref.planetary_slots.C
	var size_D = size_C + ref.planetary_slots.D
	$system_gimbal/system/A.transform.basis.x = Vector3(size_A*2, 0, 0)
	$system_gimbal/system/A.transform.basis.z = Vector3(0, 0, size_A*2)
	$system_gimbal/system/B.transform.basis.x = Vector3(size_B*2, 0, 0)
	$system_gimbal/system/B.transform.basis.z = Vector3(0, 0, size_B*2)
	$system_gimbal/system/C.transform.basis.x = Vector3(size_C*2, 0, 0)
	$system_gimbal/system/C.transform.basis.z = Vector3(0, 0, size_C*2)
	$system_gimbal/system/D.transform.basis.x = Vector3(size_D*2, 0, 0)
	$system_gimbal/system/D.transform.basis.z = Vector3(0, 0, size_D*2)

var view_mode = []
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.is_pressed():
				view_mode.push_front(1)
			else:
				view_mode.erase(1)
		if event.button_index == BUTTON_RIGHT:
			if event.is_pressed():
				view_mode.push_front(2)
			else:
				view_mode.erase(2)
		if event.button_index == BUTTON_MIDDLE:
			if event.is_pressed():
				view_mode.push_front(3)
			else:
				view_mode.erase(3)
	elif event is InputEventMouseMotion:
		if view_mode.has(1) and view_mode.has(2):
			$camera_gimbal.translation = $camera_gimbal.translation + $camera_gimbal/camera.transform.basis.y * event.relative.y/12 - $camera_gimbal/camera.transform.basis.x * event.relative.x/12
		elif view_mode.has(1):
			$camera_gimbal.rotate_y(-1*event.relative.x/50)
			$camera_gimbal/camera.rotate_x(-1*event.relative.y/50)
		elif view_mode.has(2):
			$system_gimbal/system.rotate_y(event.relative.x/50)
			$system_gimbal.rotate_x(event.relative.y/50)
		elif view_mode.has(3):
			$camera_gimbal.translation = $camera_gimbal.translation + $camera_gimbal/camera.transform.basis.z * event.relative.y/10

func _on_Back_pressed():
	get_tree().get_root().get_children()[0].show()
	$camera_gimbal/camera.current = false
	get_tree().get_root().get_children()[1].get_node("camera_gimbal/camera").current = true
	queue_free()

