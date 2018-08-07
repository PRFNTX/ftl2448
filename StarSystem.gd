extends Spatial

var ref
var star_instance = load("res://StarView.tscn")
var star_lights = {
	"O": load("res://Lighting/Blue.tscn"),
	"B": load("res://Lighting/White-Blue.tscn"),
	"A": load("res://Lighting/White.tscn"),
	"F": load("res://Lighting/Yellow-white.tscn"),
	"G": load("res://Lighting/Yellow.tscn"),
	"K": load("res://Lighting/Orange.tscn"),
	"M": load("res://Lighting/Red.tscn"),
	"N": load("res://Lighting/Dark.tscn")
}
var star_materials = {
	"O": load("res://BlueStar.tres"),
	"B": load("res://WhiteBlueStar.tres"),
	"A": load("res://WhiteStar.tres"),
	"F": load("res://Yellow-White.tres"),
	"G": load("res://YellowStar.tres"),
	"K": load("res://OrangeStar.tres"),
	"M": load("res://RedStar.tres"),
	"N": load("res://DarkStar.tres")
}
var planet_instance = load("res://PlanetView.tscn")
var system_instance = load("res://System.tscn")
var center
var stars = {

}

func _ready():
	randomize()
	ref = system_instance.instance()
	ref.start()
	init()

func init():
	var central_star = ref.stars[ref.star_slots.find(0)]
	center = star_instance.instance()
	add_child(center)
	center.translation.x =  -17
	var max_dist = ref.star_slots[0]
	for i in ref.star_slots:
		if i > max_dist:
			max_dist = i

	for star in ref.stars.size():
		if ref.star_slots[star] != 0:
			stars[ref.stars[star]] = star_instance.instance()
			add_child(stars[ref.stars[star]])
			stars[ref.stars[star]].translation.x = -17 + ref.star_slots[star]*30/max_dist

	print(ref.num_stars)
