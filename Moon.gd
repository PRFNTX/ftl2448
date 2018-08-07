extends Node

var moon_size
var moon_diameter
var moon_composition

func start(planet_type, planet_size, zone):
	moon_size = get_moon_size(planet_type, planet_size)
	moon_diameter = get_moon_diameter()
	moon_composition = get_moon_composition(zone)
	

func get_moon_composition(zone):
	var roll = int(rand_range(0,5))
	if zone == "A" or zone == "B":
		return [
			"Bombarded Rock",
			"Mineralized Rock",
			"Mineable Materials",
			"Volcanic Rock",
			"Mineable Chemicals",
			"Diversified Mix"
		][roll]
	else:
		return [
			"Water Ice",
			"Bombarded Rock",
			"Ammonia Ice",
			"Sulfur",
			"Methane",
			"Chemicals"
		][roll]


func get_moon_diameter():
	if moon_size == "small":
		return int(rand_range(10, 60))
	elif moon_size == "medium":
		return int(rand_range(0, 1000)) + 400
	elif moon_size == "large":
		return int(rand_range(0, 1600)) + 1400
	else:
		return int(rand_range(0, 2400)) + 3000

func get_moon_size(planet_type, planet_size):
	var roll = int(rand_range(0,10))
	if planet_type == 0:
		if planet_size=="small":
			if roll<=4:
				return "small"
			else:
				return "medium"
		elif planet_size=="medium":
			if roll<=4:
				return "small"
			elif roll <=9:
				return "medium"
			else:
				return "large"
		elif planet_size =="large":
			if roll <= 4:
				return "small"
			elif roll <=9:
				return "medium"
			else:
				return "large"
	elif planet_type == 1:
		if planet_size=="small":
			if roll<=4:
				return "small"
			elif roll <=7:
				return "medium"
			elif roll <=9:
				return "large"
			else:
				return "giant"
		elif planet_size=="medium":
			if roll<=4:
				return "small"
			elif roll <=7:
				return "medium"
			elif roll <=9:
				return "large"
			else:
				return "giant"
		elif planet_size =="large":
			if roll <= 3:
				return "small"
			elif roll <=6:
				return "medium"
			elif roll <=9:
				return "large"
			else:
				return "giant"
