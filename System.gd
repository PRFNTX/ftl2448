extends Node
var tree_nodes = {
	"all": ['num_stars', "special", "system_features"],
	"children": ["stars"]
}
var num_stars
var special
var system_features = []
var star_template = load("res://Star.tscn")
var stars = [
]
var star_slots = []

var planetary_view_scene = load("res://PlanetarySystem.tscn")

func start():
	num_stars = get_num_stars()
	for i in range(0, num_stars):
		stars.append(star_template.instance())
	for star in stars:
		add_child(star)
		star.initiate()
	if num_stars == 0:
		special = get_star_specials()
		if special.type == 11 or special.type == 17:
			pass
		else:
			stars.append(star_template.instance())
			stars[0].special(special)
			add_child(stars[0])
	# star placement
	if stars.size() > 0:
		var main = 0
		for star in range(0, stars.size()):
			if stars[star].read_star_size_num() > stars[main].read_star_size_num():
				main = star
			star_slots.append(1)
		star_slots[main] = 0
		# set position type
		var main_star_slots = stars[main].planetary_slots
		var minimum_distance = stars[main].planetary_slots.total + 1
		for star in range(0, stars.size()):
			if star != main:
				var pos_type = int(rand_range(1, 100))
				var slot = 0
				if pos_type <= 85:
					slot = int(rand_range(1, 100)) * 10 + main_star_slots.total
				elif pos_type <= 92:
					slot = main_star_slots['A']+main_star_slots['B']+main_star_slots['C']+int(rand_range(1, main_star_slots['D']))
				elif pos_type <= 97:
					slot = main_star_slots['A']+main_star_slots['B']+int(rand_range(1, main_star_slots['C']))
				elif pos_type <= 99:
					slot = main_star_slots['A']+int(rand_range(1, main_star_slots['B']))
				else:
					slot = int(rand_range(1, main_star_slots['A']))
				star_slots[star]=slot
		#Group Orbits
		var groups = []
		var are_in_groups = []
		for pos in range(0, star_slots.size()):
			var check = star_slots[pos]
			var group = []
			for compare in range(pos + 1, star_slots.size()):
				if abs(pos-compare) < 3:
					if not are_in_groups.has(pos):
						are_in_groups.append(pos)
					if group.size() == 0:
						group.append(pos)
					if not are_in_groups.has(compare):
						are_in_groups.append(compare)
					group.append(compare)
				else:
					if group.size() > 0:
						groups.append(group)
					break
		var found = are_in_groups.size() > 0
		#while found and groups!=null:
		#	found = false
		#	for pos in are_in_groups:
		#		var is_in = []
		#		for group_num in groups.size():
		#			if groups[group_num].has(pos):
		#				is_in.append(group_num)
		#		if is_in.size() > 1:
		#			found = true
		#			var base_group = groups[is_in[0]]
		#			for other_group in range(0,is_in.size()-1):
		#				for item in groups[other_group]:
		#					base_group.append(item)
		#			for other_group in range(is_in.size(), 1, -1):
		#				groups.remove(other_group)
		#			break
		#groups contain slot numbers
		# star in slot group[i] = stars[star_slots.find(group[i])]
		for group in groups:
			var largest = stars[star_slots.find(group[0])]
			var largest_ind = 0
			for i in range(0, group.size()):
				if stars[star_slots.find(group[i])].read_star_size_num() > largest.read_star_size_num():
					largest = stars[star_slots.find(group[i])]
					largest_ind = i
			largest.orbits = stars[star_slots.find(0)]
			for star in range(0, group.size()):
				var the_star = stars[star_slots.find(group[star])]
				# for planet in the_star.planets:
				#	planet.queue_free()
				# the_star.planets = []
				largest.orbited_by.append(stars[star_slots.find(group[star])])
		# holy fuck
	system_features = get_system_features()
	#var star_light = lights[stars[star_slots.find(0)].spectral_class.spectral]
	#var star_material = materials[stars[star_slots.find(0)].spectral_class.spectral]
	#$star.set_material_override(star_material)
	#$star.add_child(star_light.instance())
	

func get_num_stars():
	var roll = int(rand_range(1, 100))
	if roll <= 90:
		return 1
	elif roll <= 95:
		return 2
	elif roll <= 98:
		return 3
	elif roll <= 99:
		return 3 + int(rand_range(1,4))
	else:
		return 0
	

func get_system_features():
	var num = int(rand_range(1,6))
	var features = []
	for i in range(0, num):
		var roll = int(rand_range(1,20))
		features.append([
			"Gas Giant with rings",
			"Planet with rings",
			str(int(rand_range(1,4))) + " planets with rings",
			"Asteroid belt in A zone",
			"Asteroid belt in B zone",
			"Asteroid belt in C zone",
			"Asteroid belt in D zone",
			"Asteroid belt is dense",
			"Shattered planet, mostly intact",
			"Asteroids with erratic orbits",
			str(int(rand_range(1,4))) + " gas giants with rings",
			"Geologically active moon orbiting a planet",
			"Geologically active moon oribiting a gas giant",
			"High mineralization asteroid belt",
			"Masses of cometary fragments",
			"Ejected stellar debris, possible hot/radioactive clouds",
			"Very high sunspot activity increases radiation bursts of 4 x 1000 rads per hour. Phase drive untunes 6 points per day in high flare areas",
			"Two moons sharing same orbit",
			"Moon with high chemical compisition",
			"planet with high or specific chemical composition"
		][roll])
		

func get_star_specials():
	var roll = int(rand_range(1,100))
	if roll <= 20:
		return {
		"type": 0,
		"description": "Old nova,  stellar corpse, no planets",
		"planets": false
	}
	elif roll <= 30:
		return {
			"type": 1,
			"description": "Old nova, with planets",
			"planets": true
		}
	elif roll <= 40:
		return {
			"type": 2,
			"description": "Old nova, gas (debris), cloud nebula extends " + int(rand_range(1, 4)) + " light years around planet",
			"planets": false
		}
	elif roll <=50:
		return {
			"type": 3,
			"description": "very close binaries exchanging gasses",
			"planets": false
		}
	elif roll <= 60:
		return {
			"type": 4,
			"description": "Close binary, deformed by mutual gravity",
			"planets": false
		}
	elif roll <= 70:
		return {
			"type": 5,
			"description": "Dead cold star with planets",
			"planets": true
		}
	elif roll <= 80:
		return {
			"type": 6,
			"description": "Cephid A, variable star with a " + int(rand_range(1, 10)) + " year fluctuating period of intensity",
			"planets": false,
		}
	elif roll <= 90:
		return {
			"type": 7,
			"description": "Cephid B, variable star with a " + int(rand_range(1, 10)) + " day fluctuating period of intensity",
			"planets": false,
		}
	elif roll <= 95:
		return {
			"type": 8,
			"description": "Cephid C, variable star with a " + int(rand_range(1, 20)) + "hour fluctuating period of intensity",
			"planets": false
		}
	elif roll <= 98:
		return {
			"type": 9,
			"description": "semi-formed planets orbiting star",
			"planets": true
		}
	elif roll <= 99:
		return {
			"type": 10,
			"description": "Proto-star in formation",
			"planets": false
		}
	else:
		var roll2 = int(rand_range(1, 100))
		if roll2 <= 50:
			return {
				"type": 11,
				"description": "Large nebula " + int(rand_range(2, 12)) + " light years accross" 
			}
		elif roll2 <= 75:
			return {
				"type": 12,
				"description": "nova within " + int(rand_range(1, 1200)) + " months"
			}
		elif roll2 <= 90:
			return {
				"type": 13,
				"description": "Unstable cephid, variable period chaning intensity"
			}
		elif roll2 <= 97:
			return {
				"type": 14,
				"description": "Unstable Proto-star"
			}
		elif roll2 <= 98:
			return {
				"type": 15,
				"description": "Unstable, high radiation emitting star"
			}
		elif roll2 <= 99:
			return {
				"type": 16,
				"description": "Very unstable star"
			}
		else:
			return {
				"type": 17,
				"description": "small black hole"
			}


func _on_StaticBody_input_event(camera, event, click_position, click_normal, shape_idx ):
	if event is InputEventMouseButton and event.is_pressed():
		var show_system = planetary_view_scene.instance()
		show_system.ref = stars[0]
		show_system.init()
		get_tree().get_root().get_node('globals').set_current_camera(show_system.get_node("camera_gimbal/camera"))
		get_tree().get_root().add_child(show_system)
		get_tree().get_root().get_children()[0].hide()

func set_selected(boo):
	if boo:
		$selection.show()
	else:
		$selection.hide()
