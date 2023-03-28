extends Area2D
onready var HP_planet=10000
onready var max_HP_planet=10000
onready var speed_beckround=10



var _position:Vector2
var Array_Of_Squares:Array
var Side_Box:float=32
var Size_Box:float=32
var Center:Vector2
var radius:float

var SPEED=0.5
var angular_speed = PI



func _ready():
	print("in ready of name "+ $".".get_name())
	Globals.Planets=self
	#get_tree().call_group("Bar","update_HP",HP_planet)
	#get_tree().call_group("Bar","set_max_HP",max_HP_planet)
	Events.emit_signal("_HP_Planet_max",max_HP_planet)
	Events.emit_signal("_HP_Planet",HP_planet)
	
func _physics_process(_delta):
	rotation_degrees += angular_speed * _delta

func get_global_position()->Vector2:
	return global_position


func get_Radius()->float:
	return $CollisionShape2D.get_shape().get_radius()

func take_damage(damage:int):
	HP_planet-=damage
	Events.emit_signal("_HP_Planet",HP_planet)
	#get_tree().call_group("Bar","update_HP",HP_planet)
	if HP_planet<=0:
		Globals.Planets=null
		Globals.Planets=null
		GameOver()

func GameOver():
	Events.emit_signal("_GameOver")
	#get_tree().change_scene("res://GameFile/GUI/Start menu/Main_Menu.tscn")
	pass





