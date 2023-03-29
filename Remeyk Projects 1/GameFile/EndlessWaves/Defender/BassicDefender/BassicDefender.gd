extends StaticBody2D
class_name BassicDefender

#---------About_Weapons---------------------------
export var Icon:Texture
export var Name:String
export var Level:int=1
export var Damage:float=1.0
export var Speed:float=0.1
export var TypeOfDamage:String
export var Damage_per_second:float=0.0
export var Cooldown:float=0.0
export var Description:String
export var Price_gold:int=0
export var Price_Metal:int=0
export var Slowdown:float=0.0
#-------------------------------------------------

#-------------------------------------------------
var Icon_gun
var Fire:bool=false
var Asteroid:Object
var _Timer:float=0.0
var Number_of_shots:int=0
var Bullet:PackedScene
#-------------------------------------------------

#-------------------------------------------------
var dragMouse:bool=false
var check_position_Planet:bool=false
var not_overlay_gun:bool=true


#------------------------------------------------
var is_dragMouse = false
var is_colliding_Planet = false
var is_colliding_Weapons = false
var is_Active_Info_Panel:bool=false
#-------------------------------------------------
func _get_Installation_Status()->bool:
	if _get_is_dragMouse() and _get_is_colliding_Planet() and !_get_is_colliding_Weapons():
		return true
	else:
		return false
func _set_is_dragMouse(_is_dragMouse:bool)->void:
	is_dragMouse=_is_dragMouse
func _get_is_dragMouse()->bool:
	return is_dragMouse
func _set_is_colliding_Planet(_is_colliding_Planet:bool)->void:
	is_colliding_Planet=_is_colliding_Planet
func _get_is_colliding_Planet()->bool:
	return is_colliding_Planet
func _set_is_colliding_Weapons(_is_colliding_Weapons:bool)->void:
	is_colliding_Weapons=_is_colliding_Weapons
func _get_is_colliding_Weapons()->bool:
	return is_colliding_Weapons
func _get_is_active_Info_Panel()->bool:
	if !_get_is_dragMouse() and _get_is_colliding_Planet() and !_get_is_colliding_Weapons() :
		return true
	else:
		return false
func _get_Attack_Permission_Status()->bool:
	if !is_dragMouse and is_colliding_Planet and !is_colliding_Weapons and get_Asteroid()!=null:
		return true
	else:
		return false
#-------------------------------------------------
#-------------------------------------------------


func _ready():
	add_to_group("Defender")
	_set_is_dragMouse(true)

#----------------------preliminary preparation-----------------------
func set_preload_bullet(_bullet:PackedScene)->void:
	if _bullet!=null:Bullet=_bullet
#--------------------------------------------------------------------
	
#--------------------otaki-logic-------------------------------------
#------receive,-return-asteroid--------------------------------------
func set_Asteroid(targetAsteroid:Object) -> void:
	if targetAsteroid==null || !is_instance_valid(targetAsteroid):
		set_Fire(false)
		Asteroid=null
	else:
		set_Fire(true)
		Asteroid=targetAsteroid 
		look_at(targetAsteroid.global_position)
		set_number_of_shots(targetAsteroid)
func get_Asteroid()->Object:
	if !is_instance_valid(Asteroid):
		Asteroid = null
	return Asteroid
func get_asteroid_id()-> int:
	if !is_instance_valid(Asteroid):
		return -1
	return Asteroid.spawn_id		
func get_Asteroid_global_position()->Vector2:
	if get_Asteroid() != null:
		return get_Asteroid().global_position
	else: 
		return Vector2.ZERO
#------------------------------------------


#------number of shots fired at an asteroid--------------------------
func set_number_of_shots(_Asteroid) -> void:
	Number_of_shots=stepify(_Asteroid.get_HP_Enemies()/get_Damage()*2,1)
func get_number_of_shots()->int:
	return Number_of_shots
func change_number_of_shots(number:int=2)->void:
	Number_of_shots-=number
#------------------------------------------


#-----------time-between-shots-------------
func set_Timer(_timer:float)->void:
	if _timer>=0:_Timer=_timer
func get_Timer()->float:
	return _Timer
func time_change(_timer:float)->void:
	_Timer+=_timer
#------------------------------------------


#-------creating and launching bullets-----
func new_Bullet(pos1=null,pos2=null) -> void:
	var target_asteroid = get_Asteroid()
	if target_asteroid == null or Bullet==null:
		print("Error BassicDefender func new_Bullet")
		return
		
	if pos1!=null and pos2==null:
		var new_Bullit1 = Bullet.instance()
		new_Bullit1.position = pos1.global_position
		new_Bullit1.set_damage(get_Damage())
		
		new_Bullit1.set_Speed(get_Speed())
		new_Bullit1.set_Direction(intercept_point(target_asteroid))
		
		
		get_tree().get_root().add_child(new_Bullit1) 
	elif pos1!=null and pos2!=null:
		
		var new_Bullit1 = Bullet.instance()
		var new_Bullit2 = Bullet.instance()
		
		new_Bullit1.position = pos1.global_position
		new_Bullit2.position = pos2.global_position
		
		new_Bullit1.set_damage(get_Damage())
		new_Bullit2.set_damage(get_Damage())
		
		new_Bullit1.set_Direction(intercept_point(target_asteroid))
		new_Bullit2.set_Direction(intercept_point(target_asteroid))
		
		new_Bullit1.set_Speed(get_Speed())
		new_Bullit2.set_Speed(get_Speed())
		
		get_tree().get_root().add_child(new_Bullit1) 
		get_tree().get_root().add_child(new_Bullit2) 
	else:print("Error new Bullet")
#------------------------------------------


#calculation of the point of intersection of the trajectories of an asteroid and a bullet (approximate)
func intercept_point(ca) -> Vector2: #вычисление точки пересечения траекторий астероида и пули (примерное)
	return ca.global_position + Vector2(global_position.distance_to(ca.global_position)/2/get_Speed()*ca.get_Speed(),
		0).rotated(ca.rotation)
#------------------------------------------


#------Fire-is-true-false------------------
func set_Fire(_fire:bool)->void:
	Fire=_fire
func get_Fire()->bool:
	return Fire
#------------------------------------------


#-----------Speed_flay_bullit--------------
func set_Speed(_speed:float)->void:
	if _speed>=0:
		Speed=_speed
func get_Speed()->float:
	return Speed
#------------------------------------------


#-----------Icon()-------------------------
func set_Icon(_Icon:String="")->void:
	if _Icon=="":return
	Icon=load(_Icon)
	#Icon_gun.set_texture(Icon)
func get_Icon()->Texture:
	return Icon
#------------------------------------------


#-----------Name()-------------------------
func set_Name(_Name:String="default")->void:
	if _Name=="":return
	Name=_Name
func get_Name()->String:
	return Name
#------------------------------------------


#-----------Level()------------------------?
func up_Level()->void:
	Level+=1
	set_Gold(get_Gold()*2)
	set_Metal(get_Metal()*2)
	set_Damage(get_Damage()+get_Damage()/2)
	set_Damage_per_second()
	pass	
func get_Level()->int:
	return Level
#------------------------------------------


#-----------Damage()-----------------------
func set_Damage(_Damage:float=1.0)->void:
	if _Damage<=0:return
	Damage=_Damage
func get_Damage()->float:
	return Damage
#------------------------------------------


#----------TypeOfDamage()------------------
func set_TypeOfDamage(_TypeOfDamage:String="default")->void:
	if _TypeOfDamage=="":return
	TypeOfDamage=_TypeOfDamage
func get_Type_Of_Damage()->String:
	return TypeOfDamage
#------------------------------------------


#----------Damage_per_second()-------------
func set_Damage_per_second()->void:
	Damage_per_second=stepify(float(get_Damage()/get_Cooldown()),0.01)
func get_Damage_per_second()->float:
	return Damage_per_second
#------------------------------------------


#----------Cooldown()----------------------
func set_Cooldown(_Cooldown:float=1.0)->void:
	if _Cooldown<0:return
	Cooldown=_Cooldown
func get_Cooldown()->float:
	return Cooldown
#------------------------------------------


#----------Price()----------------------------------------------------------------------
#----------Price_gold----------------------
func set_Gold(_Price_gold:int=1)->void:
	if _Price_gold<0:return
	Price_gold=_Price_gold
func get_Gold()->int:
	return Price_gold
#------------------------------------------


#---------Price_Metal----------------------
func set_Metal(_Price_Metal:int=1)->void:
	if _Price_Metal<0:return
	Price_Metal=_Price_Metal
func get_Metal()->int:
	return Price_gold
#---------------------------------------------------------------------------------------


#----------Description()-------------------
func set_Description(_Description:String="default")->void:
	if _Description=="":return
	Description=_Description
func get_Description()->String:
	return Description
#------------------------------------------


#------------------------------------------
func set_Slowdown(_Slowdown:float)->void:
	Slowdown=_Slowdown
func get_Slowdown()->float:
	return Slowdown
#------------------------------------------
#------------------------------------------


#---------Input_event-click-gun------------
func _on_BassicDefender_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		if _get_Installation_Status():
			_set_is_dragMouse(false)
			Events._set_Buy_Item_Status(false)
		if _get_is_active_Info_Panel():
			Events.emit_signal("_Info_Panel_",self)
#------------------------------------------



#-------physics_process--------------------
func _physics_process(_delta):
	if _get_is_dragMouse():
		set_global_position(.get_global_mouse_position())
#------------------------------------------



#-----_on_Is_colliding_Planet--------------------
func _on_Is_colliding_Planet_area_(area, _is_colliding_):
	if area.is_in_group("PLANET"):
		_set_is_colliding_Planet(_is_colliding_)
#------------------------------------------------
#-----_on_Is_colliding_Weapons-------------------
func _on_Is_colliding_Weapons_body(body, _is_colliding_):
	if body==self:return
	if get_tree().get_nodes_in_group("Defender").size()==1:
		_set_is_colliding_Weapons(_is_colliding_)
	elif _get_is_dragMouse():
		_set_is_colliding_Weapons(_is_colliding_)
#------------------------------------------------
#------------------------------------------------

func weapon_removal():
	
	queue_free()
	return null






