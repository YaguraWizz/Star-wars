extends Node2D

onready var AnimDedAsteroid:= preload("res://GameFile/EndlessWaves/Enemies/Asteroid/Anim_ded_asteroid.tscn")
onready var Asteroid:= preload("res://GameFile/EndlessWaves/Enemies/Asteroid/Asteroids.tscn")
onready var Asteroid2:= preload("res://GameFile/EndlessWaves/Enemies/BassicEnemies/All_Asteroids/Fiery_Asteroid/Fiery_Asteroid.tscn")


var cols=0
var spawned_asteroid_count:int = 1

func _ready():
	print("in ready of name "+ $".".get_name())
	Globals.EndlessWaves=self
	randomize()
	#nev_spawn_asteroids(10)
	
	
func _physics_process(delta):
	cols+=delta
	if cols>=15:
		#nev_spawn_asteroids(20)
		cols=0
	pass

func nev_spawn_asteroids(num):
	var temp=Vector2.ZERO
	while(num > 0):
		var x=randi()%4
		var new_asteriod = Asteroid2.instance() 
		match x:
			0:temp=Vector2(rand_range(-1000,1000), rand_range(-1000,-800))
			1:temp=Vector2(rand_range(-1000,1000), rand_range(1000,800))
			2:temp=Vector2(rand_range(-1000,-800), rand_range(-1000,1000))
			3:temp=Vector2(rand_range(1000,800), rand_range(-1000,1000))
		new_asteriod.position=temp
		new_asteriod.spawn_id = spawned_asteroid_count
		spawned_asteroid_count+=1
		add_child(new_asteriod) 
		num -= 1
		
func anim_ded(velositi:Vector2):
	var DedAsteroid=AnimDedAsteroid.instance() 
	DedAsteroid.position=velositi
	get_tree().get_root().add_child(DedAsteroid) 


