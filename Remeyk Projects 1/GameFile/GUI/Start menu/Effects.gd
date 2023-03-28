extends Node2D

onready var Asteroid:= preload("res://GameFile/EndlessWaves/Enemies/Asteroid/Asteroids.tscn")
onready var position_2d = $Position2D
onready var position_2_d_4 = $Position2D4
onready var position_2_d_2 = $Position2D2

var cols=0
var spawned_asteroid_count:int = 1

func _ready():
	Globals.EndlessWaves=self
	randomize()
	nev_spawn_asteroids(3)
	
	
func _physics_process(delta):
	cols+=delta
	if cols>=15:
		nev_spawn_asteroids(0)
		cols=0
	pass

func nev_spawn_asteroids(num):
	var temp1=Vector2.ZERO
	var temp2=Vector2.ZERO
	while(num > 0):
		#print(num)
		var new_asteriod = Asteroid.instance() 
		for i in 4:
			temp1=Vector2(rand_range(0,200), rand_range(0,-200))
			temp2=Vector2(rand_range(-330,2000), rand_range(-100,2000))
			
		new_asteriod.test_UI(temp2)
		new_asteriod.position=temp1
		new_asteriod.spawn_id = spawned_asteroid_count
		spawned_asteroid_count+=1
		add_child(new_asteriod) 
		num -= 1
