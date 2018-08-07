extends Spatial


func _ready():
	set_process_input(true)

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
			$system_gimbal/SystemMapDetails.rotate_y(event.relative.x/50)
			$system_gimbal.rotate_x(event.relative.y/50)
		elif view_mode.has(3):
			$camera_gimbal.translation = $camera_gimbal.translation + $camera_gimbal/camera.transform.basis.z * event.relative.y/10