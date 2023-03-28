extends Area2D

var colision=true

var SPEED=1
var HP_comet:float=1
var damage=25
var diamond=1
var col_temp=0

var pos_chentr:Vector2
var oneshot:bool=true
var UI:bool=false
var spawn_id:int = 0
var velocity2:Vector2
var timer



func _ready():
	HP_comet=rand_range(0,40)
	timer = $Timer
	timer.start()
func get_speed():
	return SPEED

func get_HP():
	return HP_comet
	
func get_glob_position():
	return self.global_position
	
func _physics_process(_delta):
	pos_chentr=$Position2D.global_position
	
	if Globals.Planets and !UI:
		if colision:
			look_at(Globals.Planets.global_position)
			var velocity = global_position.direction_to(Globals.Planets.global_position) * SPEED
			translate(velocity)
	else:
		if colision:
			look_at(velocity2)
			var velocity = global_position.direction_to(velocity2) * SPEED
			translate(velocity)
		
func _on_Asteroid_area_entered(area):
	#print(area)
	if area.is_in_group("PLANET") and oneshot and !UI:
		Globals.Skaner.clear_target_array(self,"planet")
		area.take_damage(damage)
		Globals.EndlessWaves.anim_ded(global_position)
		colision=false
		queue_free()
	elif UI:
		Globals.anim_ded(global_position)
		colision=false
	
	
func take_damage(_damage):
	col_temp+=1
	HP_comet-=_damage
	if HP_comet<=0 and oneshot:
		Globals.Skaner.clear_target_array(self,"defender")
		colision=false
		#get_tree().call_group("Bar","update_Diamonds",diamond)
		get_tree().call_group("Bar","update_Metal",rand_range(0,3))
		#get_tree().call_group("Bar","update_Elixir",diamond)
		get_tree().call_group("Bar","update_gold",rand_range(0,3))
		Globals.EndlessWaves.anim_ded(global_position)
		queue_free()

func slowdown(_slowdown:float)->void:
	if HP_comet>0 and oneshot:
		SPEED=_slowdown
	pass


func target_center_return():
	return pos_chentr

func test_UI(vec:Vector2)->void:
	UI=true
	velocity2=vec
	

func _on_Timer_timeout():
	show()
	queue_free()
