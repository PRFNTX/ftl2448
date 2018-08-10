extends Spatial


var initial_system_trans = Transform(
	Vector3(0.850888,0,-0.525348),
	Vector3(0,1,0),
	Vector3(0.525348,0,0.850888),
	Vector3(0,0,0)
)
var initial_system_gimbal_trans =  Transform(
	Vector3(1,0,0),
	Vector3(0,1,0),
	Vector3(0,0,1),
	Vector3(0,0,0)
)
var initial_system_gimbal_pos =  Vector3(0,0,0)
var initial_camera_gimbal_pos = Vector3(0,0,50)
var initial_camera_gimbal_trans = Transform(
	Vector3(1,0,0),
	Vector3(0,1,0),
	Vector3(0,0,1),
	Vector3(0,0,50)
)
func _ready():
	set_process_input(false)
	
func activate():
	$camera_gimbal/camera.current = true
	set_process_input(true)
	$UI.show()
	make_tree()

func deactivate():
	$camera_gimbal.transform = initial_camera_gimbal_trans
	$camera_gimbal.translation = initial_camera_gimbal_pos
	$system_gimbal.transform = initial_system_gimbal_trans
	$system_gimbal.translation = initial_system_gimbal_pos
	$system_gimbal/system.transform = initial_system_trans
	
	$camera_gimbal/camera.current = false
	set_process_input(false)
	$UI.hide()
	make_tree()

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