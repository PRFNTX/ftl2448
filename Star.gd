extends Node
var is_special = false
var star_special
var star_size setget ,read_star_size
var spectral_class
var planetary_slots
var planets = []
var planet_slots = []
var orbits
var orbited_by = []
var planet_template = load("res://Planet.tscn")

func special(special):
	is_special = true
	star_special = special
	star_size = get_star_size()
	spectral_class = get_spectral_class()
	planetary_slots = get_planetary_slots()
	if star_special.planets:
		make_planets()

func initiate():
	star_size = get_star_size()
	spectral_class = get_spectral_class()
	planetary_slots = get_planetary_slots()
	make_planets()

func make_planets():
	for i in range(0, planetary_slots.planets):
		planets.append(planet_template.instance())
	for planet in range(0, planets.size()):
		add_child(planets[planet])
		var placement = planets[planet].start()
		var slot = 0
		var last = 0
		if placement == "A":
			slot = int(rand_range(last + 1, last + planetary_slots.A))
		elif placement == "B":
			last = planetary_slots.A
			slot = int(rand_range(last + 1, last + planetary_slots.B))
		elif placement == "C":
			last = planetary_slots.A + planetary_slots.B
			slot = int(rand_range(last + 1, last + planetary_slots.C))
		else:
			last = planetary_slots.A + planetary_slots.B + planetary_slots.C
			slot = int(rand_range(last + 1, last + planetary_slots.D))
		planet_slots.append(slot)
		# planets[planet].slot = slot
	
	for planet in planets:
		planet.classify()

func get_slot_letter_from_number(num):
	var l_num = num
	if l_num <= planetary_slots.A:
		return "A"
	l_num -= planetary_slots.A
	if l_num <= planetary_slots.B:
		return "B"
	l_num -= planetary_slots.B
	if l_num <= planetary_slots.C:
		return "C"
	return "D"

func get_star_size():
	var roll = int(rand_range(1, 100))
	if roll <= 10:
		return 1
	elif roll <= 40:
		return 2
	elif roll <= 85:
		return 3
	elif roll <= 95:
		return 4
	elif roll <= 98:
		return 5
	else:
		return 6

func get_spectral_class():
	var roll = int(rand_range(1, 100))
	if roll <= 2:
		return {
			"color": "Dark",
			"spectral": "N",
			"temp": "2000"
		}
	elif roll <= 45:
		return {
			"color": "Red",
			"spectral": "M",
			"temp": "3500"
		}
	elif roll <= 55:
		return {
			"color": "Orange",
			"spectral": "K",
			"temp": "5000"
		}
	elif roll <= 74:
		return {
			"color": "Yellow",
			"spectral": "G",
			"temp": "6000"
		}
	elif roll <= 89:
		return {
			"color": "Yellow-White",
			"spectral": "F",
			"temp": "7000"
		}
	elif roll <= 96:
		return {
			"color": "White",
			"spectral": "A",
			"temp": "10000"
		}
	elif roll <= 99:
		return {
			"color": "Blue-White",
			"spectral": "B",
			"temp": "23000"
		}
	else:
		return {
			"color": "Blue",
			"spectral": "O",
			"temp": "25000"
		}

func get_planetary_slots():
	var table = {
		"O": [3,4,5,6,7,8],
		"B": [3,4,5,6,7,8],
		"A": [2,3,4,5,6,7],
		"F": [1,2,3,4,5,6],
		"G": [1,2,3,4,5,6],
		"K": [1,2,3,4,5,6],
		"M": [1,1,2,3,4,5],
		"N": [1,1,1,2,3,4]
	}
	var slots = [
		{"total": 6, "A": 1, "B": 1, "C": 2, "D": 2, "planets": int(rand_range(0, 3))},
		{"total": 12, "A": 2, "B": 2, "C": 4, "D": 4, "planets": int(rand_range(0, 6))},
		{"total": 20, "A": 4, "B": 4, "C": 6, "D": 6, "planets": int(rand_range(0, 9))},
		{"total": 24, "A": 4, "B": 4, "C": 8, "D": 8, "planets": int(rand_range(0, 9))},
		{"total": 32, "A": 6, "B": 6, "C": 10, "D": 10, "planets": int(rand_range(0, 9))},
		{"total": 40, "A": 8, "B": 8, "C": 12, "D": 12, "planets": int(rand_range(0, 11))},
		{"total": 60, "A": 10, "B": 10, "C": 20, "D": 20, "planets": int(rand_range(0, 11))},
		{"total": 64, "A": 12, "B": 12, "C": 20, "D": 20, "planets": int(rand_range(0, 19))},
	]
	return slots[table[spectral_class['spectral']][star_size-1]-1]

func read_star_size_num():
	return star_size

func read_star_size():
	var names = [
		"dwarf",
		"small",
		"medium",
		"Large",
		"Giant",
		"Super Giant"
	]
	return names[star_size]
