extends Node

var maxCol = 31
var numRows = 41
onready var totalHexes = pow(numRows - (maxCol/2), 2) + pow(maxCol/2, 2)
onready var systemTemplate = load('res://System.tscn')
var systems = []
var cursor = 0

func cursor_to_pos(cursor):
	var count = cursor
	var x = 0
	var y = -20
	for i in range(1, 31):
		if count > i:
			count -= i 
			y += 1
		else:
			x = count - i/2
			count = 0
			break
	if count > 0:
		for j in range(0, 20):
			if count > 40:
				count -= j 
				y += 1
			else:
				x = count - 20
				count = 0
				break
	if count > 0:
		for k in range(31, 0, -1):
			if count > k:
				count -= k 
				y += 1
			else:
				x = count - k/2
				count = 0
				break
	return [x, y]

func add_system():
	var move = int(rand_range(3, 60)) #should be 100
	cursor += move
	print(str(cursor) + " of " + str(totalHexes))
	if cursor < totalHexes:
		var pos = cursor_to_pos(cursor)
		var system = systemTemplate.instance()
		self.add_child(system)
		system.start()
		var next_system = {
			"x": pos[0],
			"y": pos[1],
			"z": int(rand_range(-20, 20)),
			"system": system
		}
		system.translation.x = next_system.x
		system.translation.y = next_system.y*.5
		system.translation.z = next_system.z
		#system.get_node("star/drop").transform.basis.z = Vector3(0, 0, next_system.z + 20)
		#system.get_node("star/drop").translation.z = (next_system.z + 20) /2
		return next_system
	else:
		return false


func get_hex_position(row, col):
	return col - col/2 + row%1



func _ready():
	randomize()
	var space = true
	var num_systems = 0
	while space:
		num_systems += 1
		var next_system = add_system()
		if typeof(next_system) == TYPE_BOOL:
			space = next_system
		else:
			systems.append(next_system)
	make_tree()

var tree
var root
var tree_systems = {}
var tree_stars = {
}
var tree_planets = {}
var tree_planet_details = {}
var tree_moons = {}
var tree_moon_details = {}

func make_tree():
	tree = get_parent().get_node("UI/tree")
	root = tree.create_item()
	var i = 0
	for system in systems:
		tree_systems[i] = tree.create_item(root)
		tree_systems[i].collapsed = true
		tree_systems[i].set_text(0, "System " + str(tree_systems.size()))
		tree_systems[i].set_text(1, "stars: " + str(system.system.num_stars))
		tree_stars[system.system] = []
		for star in system.system.stars:
			tree_stars[system.system]=(tree.create_item(tree_systems[i]))
			tree_stars[system.system].collapsed = true
			tree_stars[system.system].set_text(0, "Spectral Class")
			tree_stars[system.system].set_text(1, star.spectral_class.spectral)
			for planet in star.planets:
				tree_planets[star] = tree.create_item(tree_stars[system.system])
				tree_planets[star].collapsed = true
				tree_planets[star].set_text(0, "Type:" )
				tree_planets[star].set_text(1, planet.planet_type)
				tree_planet_details[planet] = {}
				#	"tree_node": tree.create_item(tree_planets[star]),
				#}
				tree_planet_details[planet].size = planet.planet_size['class']
				var set_item = tree.create_item(tree_planets[star])
				set_item.set_text(0, "Size: ")
				set_item.set_text(1, tree_planet_details[planet].size)
				tree_planet_details[planet]['class'] = planet.planet_class
				set_item = tree.create_item(tree_planets[star])
				set_item.set_text(0, "Class: ")
				set_item.set_text(1, tree_planet_details[planet]['class'])
				tree_planet_details[planet].moons = planet.planet_size['moons']
				set_item = tree.create_item(tree_planets[star])
				set_item.set_text(0, "Moons: ")
				set_item.set_text(1, str(tree_planet_details[planet].moons))
				for moon in planet.planet_moons:
					tree_moons[moon] = tree.create_item(set_item)
					tree_moons[moon].collapsed = true
					tree_moons[moon].set_text(0, "Size: ")
					tree_moons[moon].set_text(1, moon.moon_size)
					tree_moon_details[moon] = {}
					tree_moon_details[moon].diameter = moon.moon_diameter
					var set_moon_item = tree.create_item(tree_moons[moon])
					set_moon_item.set_text(0, "Diameter: ")
					set_moon_item.set_text(1, str(tree_moon_details[moon].diameter))
					tree_moon_details[moon].composition = moon.moon_composition
					set_moon_item = tree.create_item(tree_moons[moon])
					set_moon_item.set_text(0, "Composition: ")
					set_moon_item.set_text(1, tree_moon_details[moon].composition)
		i+=1


var item_selected
func _on_tree_cell_selected():
	if item_selected != null:
		item_selected.set_selected(false)
	var selected = tree.get_selected()
	var cursor = selected
	var levels = 0
	while cursor.get_parent() != null:
		cursor = cursor.get_parent()
		levels +=1
	var levels_to_var = [
		"tree_systems",
		"tree_stars",
		"tree_planets",
		"tree_planets",
		"tree_moons",
		"tree_moons"
	]
	for key in self[levels_to_var[levels-1]].keys():
		if self[levels_to_var[levels-1]][key]==selected:
			if levels == 1:
				# systems[key].system.set_selected(true)
				# item_selected = systems[key].system
				get_parent().get_node("select").translation.x = systems[key].x
				get_parent().get_node("select").translation.y = systems[key].y * 0.5
				get_parent().get_node("select").translation.z = systems[key].z - 1
			else:
				# key.set_selected(true)
				# item_selected = key
				pass


func _on_Go_to_pressed():
#	var show_system = planetary_view_scene.instance()
#	show_system.ref = stars[0]
#	show_system.init()
#	show_system.get_node("camera").current = true
#	get_tree().get_root().get_children()[0].get_node("camera").current = false
#	get_tree().get_root().add_child(show_system)
#	get_tree().get_root().get_children()[0].hide()
	pass
