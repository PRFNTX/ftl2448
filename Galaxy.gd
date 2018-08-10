extends Spatial

var systems = [
]
var world_instance = load("res://World.tscn")
func _ready():
	create_rings(1)
	create_rings(2)
	set_process_input(true)

func create_rings(n):
	var child_target = $system_gimbal/system/slider
	var ring = []
	for i in range(0, n):
		var hexes = []
		for j in range(0, max(6*i, 1)):
			var layers = []
			for l in range(0,3):
				var last = world_instance.instance()
				last.get_node("clickable").connect("input_event", self, "on_world_click")
				last.translation.y = (l - 1) * 50
				last.translation.x = j * 60
				last.translation.z = i * 80
				child_target.add_child(last)
				layers.append(last) # this should be a system
			hexes.append(layers)
		print(hexes.size())
		ring.append(hexes)
	print(ring)
	print("DONE")

func on_world_click(camera, event, click_position, click_normal, shape_index):
	if event is InputEventMouseButton:
		print(click_position)
		$system_gimbal/system/slider.translation = Vector3(-click_position.x, 0, -click_position.z)

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
		if view_mode.has(1):
			$camera_gimbal.translation = $camera_gimbal.translation + $camera_gimbal/camera.transform.basis.y * event.relative.y/12 - $camera_gimbal/camera.transform.basis.x * event.relative.x/12
		#elif view_mode.has(1):
		#	$camera_gimbal.rotate_y(-1*event.relative.x/50)
		#	$camera_gimbal/camera.rotate_x(-1*event.relative.y/50)
		elif view_mode.has(2):
			$system_gimbal/system.rotate_y(event.relative.x/50)
			$system_gimbal.rotate_x(event.relative.y/50)
		elif view_mode.has(3):
			$camera_gimbal.translation = $camera_gimbal.translation + $camera_gimbal/camera.transform.basis.z * event.relative.y/10
