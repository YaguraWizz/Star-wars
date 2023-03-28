extends Node

var EndlessWaves
var Planets
var Asteroid
var Platform
var Skaner

var Liser
var GUI
var BAR
var Globals_Dictionary_Weapons
onready var AnimDedAsteroid:= preload("res://GameFile/EndlessWaves/Enemies/Asteroid/Anim_ded_asteroid.tscn")
func anim_ded(velositi:Vector2):
	var DedAsteroid=AnimDedAsteroid.instance() 
	DedAsteroid.position=velositi
	get_tree().get_root().add_child(DedAsteroid) 
