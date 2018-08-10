extends Node

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

var current_camera

func set_current_camera(camera):
	current_camera.current = false
	current_camera = camera
	current_camera.current = true

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
