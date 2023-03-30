extends Node

onready var Asteroid2:= preload("res://GameFile/EndlessWaves/Enemies/BassicEnemies/All_Asteroids/Fiery_Asteroid/Fiery_Asteroid.tscn")
onready var Class_Pool:=preload("res://GameFile/EndlessWaves/Enemies/Pool_Maneger/Class_Pool.gd")
onready var Path_="res://GameFile/EndlessWaves/Enemies/BassicEnemies/All_Asteroids/Fiery_Asteroid/Fiery_Asteroid.tscn"
onready var Dictionary_Enemies = {}

var Pool
var cols=0
func _ready():
	print("in ready of name "+ $".".get_name())
	Pool=Class_Pool.new(Path_,3)
	randomize()
	nev_spawn_asteroids(3)

func _physics_process(delta):
	cols+=delta
	if cols>=6:
		nev_spawn_asteroids(3)
		cols=0
	pass

func nev_spawn_asteroids(num):
	var temp:Vector2=Vector2(0,0)
	while(num > 0):
		var x=randi()%4
		var new_asteriod = Pool.GetFreeElement() 
		match x:
			0:temp=Vector2(rand_range(-1000,1000), rand_range(-1000,-800))
			1:temp=Vector2(rand_range(-1000,1000), rand_range(1000,800))
			2:temp=Vector2(rand_range(-1000,-800), rand_range(-1000,1000))
			3:temp=Vector2(rand_range(1000,800), rand_range(-1000,1000))
		new_asteriod.set_position(temp)
		if !new_asteriod._get_is_the_scene_loaded():
			new_asteriod._set_is_the_scene_loaded(true)
			add_child(new_asteriod) 
		else:
			new_asteriod.up_date_live()
			
		num -= 1
	pass

class Enemies:
		#--------Object Fields----------------------------------------------------------
	var Name:String 
	var Damag:float 
	var Speed:float 
	var Gold:int  
	var Metal:int 
	var HP_Enemies:int 
	var Initial_State:bool
	#-------------------------------------------------------------------------------
	func _init(_Name:String,_Damag:float,_Speed:float,_Gold:int,_Metal:int,_HP_Enemies:int,_Initial_State:bool=false):
		Name=_Name
		Damag=_Damag
		Speed=_Speed
		Gold=_Gold
		Metal=_Metal
		HP_Enemies=_HP_Enemies
		pass
	#--------------------------------------------------
	func get_Name()->String:
		return Name
	#--------------------------------------------------

	#--------------------------------------------------
	func get_Damag()->float:
		return Damag
	#--------------------------------------------------

	#--------------------------------------------------
	func get_Speed()->float:
		return Speed
	#--------------------------------------------------

	#--------------------------------------------------
	func get_Gold()->int:
		return Gold
	#--------------------------------------------------

	#--------------------------------------------------
	func get_Metal()->int:
		return Metal
	#--------------------------------------------------

	#--------------------------------------------------
	func get_HP_Enemies()->int:
		return HP_Enemies
	#--------------------------------------------------

	#--------------------------------------------------
	func get_Initial_State()->bool:
		return Initial_State
	#--------------------------------------------------
