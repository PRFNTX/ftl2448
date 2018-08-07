extends Node

var planet_type setget , read_planet_type
var planet_placement
var planet_size
var planet_moons = []
var planet_class
var climate
var breathability
var geology
var landmass
var life_details
onready var moon_template = load("res://Moon.tscn")

func start():
	var moon_template = load("res://Moon.tscn")
	planet_type = get_planet_type()
	planet_placement = get_planet_placement()
	planet_size = get_planet_size()
	for i in range(0, planet_size.moons):
		var moon = moon_template.instance()
		add_child(moon)
		planet_moons.append(moon)
		moon.start(planet_type, planet_size["class"], planet_placement)
	return planet_placement

func classify():
	planet_class = get_habitability()
	climate = get_climate()
	breathability = get_breathability()
	landmass = get_landmass()
	geology = get_geology()
	if climate.has_life:
		life_details = get_life_details()
	

func get_planet_type():
	var roll = int(rand_range(1,10))
	if roll <= 5:
		return 0
	else:
		return 1

func get_planet_placement():
	var roll = int(rand_range(1, 10))
	if planet_type == 0:
		if roll <= 2:
			return "A"
		elif roll <= 4:
			return "B"
		elif roll <= 7:
			return "C"
		else:
			return "D"
	else:
		if roll <= 5:
			return "C"
		else:
			return "D"
			

func get_habitability():
	var spec_to_int = ["O","B","A","F","G","K","M","N"]
	var slot = get_parent().planet_slots[get_parent().planets.find(self)] - 1
	if slot > 19:
		return "F"
	return [
		["H","H","H","H","H2","H2","H2","H3","H3","H3","H4","H4","H4","M1","M2","M3","F4","F4","F3","F3"],
		["H","H2","H2","H2","H3","H3","H3","H4","H4","H4","M1","M2","M3","F4","F4","F3","F3","F2","F2","F"],
		["H2","H3","H3","H4","H4","H4","H4","M1","M1","M2","M3","M3","F4","F4","F4","F3","F2","F2","F", "F"],
		["H3","H3","H4","H4","H4","M1","M2","M3","M3","M3","F4","F4","F3","F3","F2","F2","F","F","F","F"],
		["H4","H4","H4","M1","M2","M3","F4","F4","F3","F3","F2","F2","F","F","F","F","F","F","F","F"],
		["H4","H4","M1","M2","M3","F4","F4","F3","F3","F2","F","F","F","F","F","F","F","F","F","F"],
		["H4","M1","M2","M3","F4","F4","F3","F3","F2","F","F","F","F","F","F","F","F","F","F","F"],
		["M1","M2","M3","F4","F4","F2","F2","F2","F","F","F","F","F","F","F","F","F","F","F", "F"],
	][spec_to_int.find(get_parent().spectral_class.spectral)][slot]
	

func get_landmass():
	var roll = int(rand_range(1, 100))
	if roll <= 10:
		return "Unbroken landmasses"
	elif roll <= 25:
		return "super continents"
	elif roll <= 75:
		return "several large continents"
	elif roll <= 98:
		return "continents and islands"
	elif roll <= 99:
		return "small continents and islands"
	else:
		return "island chains"

func get_geology():
	var roll = int(rand_range(1, 100))
	if roll <= 10:
		return "geological hell"
	elif roll <=25:
		return "highly active geology"
	elif roll <= 75:
		return "active geology"
	elif roll <- 95:
		return "passive geology"
	else:
		return "non-active geology"

func get_life_details():
	var diversity
	var diversity_roll = int(rand_range(1, 100))
	if diversity_roll <= 5:
		diversity = "Not much, some sea creatures, some plants"
	if diversity_roll <= 10:
		diversity = "sparse, , diverse plants, few suprises"
	if diversity_roll <= 25:
		diversity = "average, diverse ecology, plants and food chains"
	if diversity_roll <= 75:
		diversity = "lively, lots of diversity"
	if diversity_roll <= 95:
		diversity = "significant, competitive life, many hostile"
	else:
		diversity = "Mianiacal, competetive, diverse, almost everything will try to consume you"
		
	var intelligence
	var intelligence_roll = int(rand_range(1, 100))
	if intelligence_roll <= 50:
		intelligence = "None"
	elif intelligence_roll <= 75:
		intelligence = "Near intelligence"
	elif intelligence_roll <= 90:
		intelligence = "Primitives"
	elif intelligence_roll <= 98:
		intelligence = "Developing Culture"
	else:
		intelligence = "Developed Race"
	
	var origin
	var origin_roll = int(rand_range(1, 100))
	if origin_roll <= 25:
		origin = "Uplifted Race, raised to intelligence by Tehrmelern"
	elif origin_roll <= 75:
		origin = "Old race assited, raised to civilization by Tehrmelern"
	elif origin_roll <= 98:
		origin = "Independant development"
	else:
		origin = "Designer life forms"
	
	return {
		"diversity": diversity,
		"intelligence": intelligence,
		"origin": origin
	}

func get_breathability():
	var roll = int(rand_range(1,20))
	if roll <= 4:
		return {
			"code": "A",
			"description": "Toxic, highly poisonous",
		}
	elif roll <= 6:
		return {
			"code": "B",
			"description": "wrong mixture, toxic elements",
		}
	elif roll <= 8:
		return {
			"code": "C",
			"description": "wrong percentages, must be filtered and supplemented for use",
		}
	elif roll <= 10:
		return {
			"code": "D",
			"description": "thin, but mostly breathable",
		}
	elif roll <=11:
		return {
			"code": "E",
			"description": "Ideal",
		}
	elif roll <= 12:
		return {
			"code": "F",
			"description": "thick, but mostly breathable",
		}
	elif roll <= 13:
		return {
			"code": "G",
			"description": "Breathable with filters",
		}
	elif roll <= 15:
		return {
			"code": "H",
			"description": "Mildly toxic",
		}
	elif roll <= 19:
		return {
			"code": "I",
			"description": "Toxic, highly poisonous",
		}
	elif roll <= 20:
		return {
			"code": "J",
			"description": "Toxic, poisonous, corrosive",
		}

func get_climate():
	var moon_mod = 0
	var moon_small = 0
	var moon_med = 0
	var moon_large = 0
	for moon in planet_moons:
		if moon.moon_size == "small":
			moon_small +=1
		if moon.moon_size == "medium":
			moon_med +=1
		if moon.moon_size == "large":
			moon_large +=1
	var moons = planet_moons.size()
	
	if moon_small == 0:
		moon_mod +=1
	elif moon_small <=2:
		moon_mod += 0
	elif moon_small <=4:
		moon_mod -= 1
	elif moon_small <=9:
		moon_mod -= 2
	else:
		moon_mod -= 3

	if moon_med == 0:
		moon_mod += 1
	elif moon_med <=2:
		moon_mod -= 1
	elif moon_med <=4:
		moon_mod -= 2
	elif moon_med <=9:
		moon_mod -= 2
	else:
		moon_mod -= 4

	if moon_large == 0:
		moon_mod -= 1
	elif moon_large <=2:
		moon_mod -= 2
	elif moon_large <=4:
		moon_mod -= 3
	elif moon_large <=9:
		moon_mod -= 4
	else:
		moon_mod -= 5
	
	var pressure_mod = 0
	var roll = int(rand_range(1, 10))
	if planet_size['class'] == "small":
		if roll <=3:
			pressure_mod = -3
		elif roll <= 6:
			pressure_mod = -2
		elif roll <= 8:
			pressure_mod = -1
		elif roll <= 9:
			pressure_mod = 0
		else:
			pressure_mod = 1
	if planet_size['class'] == "medium":
		if roll <=2:
			pressure_mod = -2
		elif roll <= 4:
			pressure_mod = -1
		elif roll <= 6:
			pressure_mod = 0
		elif roll <= 8:
			pressure_mod = 1
		else:
			pressure_mod = 2
	if planet_size['class'] == "large":
		if roll <=1:
			pressure_mod = -1
		elif roll <= 2:
			pressure_mod = 0
		elif roll <= 5:
			pressure_mod = 1
		elif roll <= 8:
			pressure_mod = 2
		else:
			pressure_mod = 3
	
	var zone_mod = 0
	if planet_placement == "A":
		zone_mod = +3
	if planet_placement == "C":
		zone_mod = -3
	
	var star_mod = 0
	var star_mod_table = {
		"O": [1,2,3,4,5,6],
		"B": [0,1,2,3,4,5],
		"A": [-1,0,1,2,3,4],
		"F": [-2,-1,0,1,2,3],
		"G": [-3,-2,-1,0,1,2],
		"K": [-4,-3,-2,-1,0,1],
		"M": [-5,-4,-3,-2,-1,0],
		"N": [-6,-5,-4,-3,-2,-1],
	}[get_parent().spectral_class.spectral][get_parent().read_star_size_num()-1]
	
	var total_mod = moon_mod + pressure_mod + zone_mod + star_mod
	var climate_roll = 0
	if planet_size['class']=="small":
		climate_roll = int(rand_range(1,4))
	elif planet_size['class']=="medium":
		climate_roll = int(rand_range(1,6))
	elif planet_size['class']=="large":
		climate_roll = int(rand_range(1,4) + rand_range(1,4))
	var result = climate_roll + total_mod
	if result <= -4:
		return {
			"climate": "frozen",
			"tempurature": "-200 or lower",
			"life_chance": 0,
			"has_life": false
		}
	elif result <= -2:
		return {
			"climate": "very cold",
			"tempurature": "-200F to -100F",
			"life_chance": 1,
			"has_life": int(rand_range(1, 100)) <= 1
		}
	elif result <= 0:
		return {
			"climate": "cold",
			"tempurature": "-100F to -25F",
			"life_chance": 5,
			"has_life": int(rand_range(1, 100)) <= 5
		}
	elif result <= 2:
		return {
			"climate": "cool",
			"tempurature": "-50F to 50F",
			"life_chance": 40,
			"has_life": int(rand_range(1, 100)) <= 40
		}
	elif result <= 4:
		return {
			"climate": "terran",
			"tempurature": "-25F to 100F",
			"life_chance": 80,
			"has_life": int(rand_range(1, 100)) <= 80
		}
	elif result <= 6:
		return {
			"climate": "warm",
			"tempurature": "50F to 150F",
			"life_chance": 40,
			"has_life": int(rand_range(1, 100)) <= 40
		}
	elif result <= 8:
		return {
			"climate": "very warm",
			"tempurature": "100F to 200F",
			"life_chance": 7,
			"has_life": int(rand_range(1, 100)) <= 7
		}
	elif result <= 10:
		return {
			"climate": "hot",
			"tempurature": "150F to 250F",
			"life_chance": 2,
			"has_life": int(rand_range(1, 100)) <= 2
		}
	elif result <= 12:
		return {
			"climate": "very hot",
			"tempurature": "200F to 300F",
			"life_chance": 1,
			"has_life": int(rand_range(1, 100)) <= 1
		}
	else:
		return {
			"climate": "burning",
			"tempurature": "250F or higher",
			"life_chance": 0,
			"has_life": false
		}

func get_planet_size():
	var roll = int(rand_range(1, 10))
	if planet_type == 0:
		if roll == 1:
			var dia = int(min(rand_range(0,5499), 100))
			return {
				"class": "planetoid",
				"diameter": dia,
				"gravity": 0.6*(((dia/2)^3)/(2250^3)),
				"moons": 0
			}
		elif roll == 2:
			return {
				"class": "small",
				"diameter": int(rand_range(4500 + roll*500, 5000+roll*500)),
				"gravity": 0.6,
				"moons": int(rand_range(0,3))
			}
		elif roll == 3:
			return {
				"class": "small",
				"diameter": int(rand_range(4500 + roll*500, 5000+roll*500)),
				"gravity": 0.7,
				"moons": int(rand_range(0,3))
			}
		elif roll == 4:
			return {
				"class": "small",
				"diameter": int(rand_range(4500 + roll*500, 5000+roll*500)),
				"gravity": 0.8,
				"moons": int(rand_range(0,3))
			}
		elif roll == 5:
			return {
				"class": "medium",
				"diameter": int(rand_range(4500 + roll*500, 5000+roll*500)),
				"gravity": 0.85,
				"moons": int(rand_range(0,5))
			}
		elif roll == 6:
			return {
				"class": "medium",
				"diameter": int(rand_range(4500 + roll*500, 5000+roll*500)),
				"gravity": 0.9,
				"moons": int(rand_range(0,5))
			}
		elif roll == 7:
			return {
				"class": "medium",
				"diameter": int(rand_range(4500 + roll*500, 5000+roll*500)),
				"gravity": 1.00,
				"moons": int(rand_range(0,5))
			}
		elif roll == 8:
			return {
				"class": "large",
				"diameter": int(rand_range(4500 + roll*500, 5000+roll*500)),
				"gravity": 1.25,
				"moons": int(rand_range(0,7))
			}
		elif roll == 9:
			return {
				"class": "large",
				"diameter": int(rand_range(4500 + roll*500, 5500+roll*500)),
				"gravity": 1.5,
				"moons": int(rand_range(0,7))
			}
		elif roll == 10:
			return {
				"class": "large",
				"diameter": int(rand_range(5000 + roll*500, 6000+roll*500)),
				"gravity": 2.0,
				"moons": int(rand_range(0,7))
			}
	else: ## GAS GIANT
		if roll == 1:
			return {
				"class": "small",
				"diameter": int(rand_range(9000 + roll*1000, 10000+roll*1000)),
				"gravity": -1,
				"moons": int(rand_range(0,9))
			}
		elif roll == 2:
			return {
				"class": "small",
				"diameter": int(rand_range(9000 + roll*1000, 10000+roll*1000)),
				"gravity": -1,
				"moons": int(rand_range(0,9))
			}
		elif roll == 3:
			return {
				"class": "small",
				"diameter": int(rand_range(9000 + roll*1000, 10000+roll*1000)),
				"gravity": -1,
				"moons": int(rand_range(0,9))
			}
		elif roll == 4:
			return {
				"class": "medium",
				"diameter": int(rand_range(9000 + roll*1000, 10000+roll*1000)),
				"gravity": -1,
				"moons": int(rand_range(0,9))
			}
		elif roll == 5:
			return {
				"class": "medium",
				"diameter": int(rand_range(9000 + roll*1000, 10000+roll*1000)),
				"gravity": -1,
				"moons": int(rand_range(0,19))
			}
		elif roll == 6:
			return {
				"class": "medium",
				"diameter": int(rand_range(9000 + roll*1000, 10000+roll*1000)),
				"gravity": -1,
				"moons": int(rand_range(0,19))
			}
		elif roll == 7:
			return {
				"class": "medium",
				"diameter": int(rand_range(9000 + roll*1000, 10000+roll*1000)),
				"gravity": -1,
				"moons": int(rand_range(0,19))
			}
		elif roll == 8:
			return {
				"class": "large",
				"diameter": int(rand_range(9000 + roll*1000, 10000+roll*1000)),
				"gravity": -1,
				"moons": int(rand_range(0,19))
			}
		elif roll == 9:
			return {
				"class": "large",
				"diameter": int(rand_range(9000 + roll*1000, 25000+roll*1000)),
				"gravity": -1,
				"moons": int(rand_range(0,19))
			}
		else:
			return {
				"class": "large",
				"diameter": int(rand_range(25000 + roll*1000, 50000+roll*1000)),
				"gravity": -1,
				"moons": int(rand_range(0,19))
			}

func read_planet_type():
	if planet_type == 1:
		return "Gas Giant"
	else:
		return "Terrestrial Planet"

func read_planet_type_num():
	return planet_type
