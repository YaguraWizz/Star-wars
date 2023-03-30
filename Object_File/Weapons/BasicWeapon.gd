extends Area2D
class_name BasicWeapon
#-------------------------------------------------------------------------------
export var is_it_an_active_object:bool=false
export var whether_the_object_is_already_loaded:bool=false
#-------------------------------------------------------------------------------
export var _ID:int
export var Icon:String
export var Name:String 
export var HP_Object:int 
export var Damage:float 
export var Speed:float 
export var Gold:int  
export var Metal:int 
export var Description:String
export var Level:int
#-------------------------------------------------------------------------------
export var Cooldown:float
export var Type_Weapon:String
export var Slowdown:float
export var Path_Weapon_Element:String="res://Weapons/Weapon_Element/BasicWeaponElement.tscn"
#-------------------------------------------------------------------------------
onready var WeaponElement=WeaponElementPool.new('res://Weapons/Weapon_Element/BasicWeaponElement.tscn',3)
export var Number_Of_Rounds_Per_Shot:int=1
var Enemie:Object
var Number_of_shots:int=0
#-------------------------------------------------------------------------------
var is_dragMouse = false
var is_colliding_Planet = false
var is_colliding_Weapons = false
var is_Active_Info_Panel:bool=false
#-------------------------------------------------------------------------------
var is_shooting_Legal:bool=false


#-------------------------------------------------------------------------------
var _Weapon_Element_path_is_not_valid:bool=false
var _Icon_path_is_not_valid:bool=false
#-------------------------------------------------------------------------------
func _ready():
	print("\n\nin ready of name "+ $".".get_name())
	print("in WeaponElement ", WeaponElement)
	
	

#-------------------------------------------------------------------------------
func _Fill_In_Weapon_Parameters(_Object:Info_The_Object):
	
#--------------------------#validation of paths#--------------------------------
	if !_Object.get_Path_Weapon_Element().is_abs_path():
		_Weapon_Element_path_is_not_valid=true
		print("Error class Info_The_Object: _Path_Weapon_Element is not a path")
	if !_Object._Path_Icon().is_abs_path():
		_Icon_path_is_not_valid=true
		print("Error class Info_The_Object: _Path_Weapon_Element is not a path")
#-------------------------------------------------------------------------------
	_ID=_Object.get_ID()
	Name=_Object.get_Name()
	HP_Object=_Object.get_HP_Object()
	Damage=_Object.get_Damage()
	Speed=_Object.get_Speed()
	Gold=_Object.get_Gold()
	Metal=_Object.get_Metal()
	Description=_Object.get_Description()
	Icon=_Object.get_Path_Icon()
	if _Object.get_Cooldown()!=0:
		Cooldown=_Object.get_Cooldown()
		Slowdown=_Object.get_Slowdown()
		Type_Weapon=_Object.get_Type_Weapon()
		Level=_Object.get_Level()
		Path_Weapon_Element=_Object.get_Path_Weapon_Element()
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
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
	if !is_dragMouse and is_colliding_Planet and !is_colliding_Weapons and get_Enemie()!=null:
		return true
	else:
		return false
#-------------------------------------------------------------------------------
#------Fire-is-true-false-------------------------------------------------------
func set_is_shooting_Legal(new_shooting_value:bool)->void:
	is_shooting_Legal=new_shooting_value
func get_is_shooting_Legal()->bool:
	return is_shooting_Legal
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------

#--------------------otaki-logic------------------------------------------------
#----------------receive,-return-Enemie-----------------------------------------
func set_Enemie(targetEnemie:Object) -> void:
	if targetEnemie==null || !is_instance_valid(targetEnemie):
		set_is_shooting_Legal(false)
		Enemie=null
	else:
		set_is_shooting_Legal(true)
		Enemie=targetEnemie 
		look_at(targetEnemie.global_position)
		set_number_of_shots(targetEnemie)
func get_Enemie()->Object:
	if !is_instance_valid(Enemie):
		Enemie = null
	return Enemie
func get_Enemie_id()-> int:
	if !is_instance_valid(Enemie):
		return -1
	return Enemie.spawn_id		
func get_Enemie_global_position()->Vector2:
	if get_Enemie() != null:
		return get_Enemie().global_position
	else: 
		return Vector2.ZERO
#------------------------------------------
#------------------------------------------
#------------------------------------------

#----------number of shots fired at an Enemie-----------------------------------
func set_number_of_shots(_Enemie) -> void:
	Number_of_shots=stepify((_Enemie.get_HP_Enemies() * (3/(get_Number_Of_Rounds_Per_Shot()*get_Damage()))),1) as int
func get_number_of_shots()->int:
	return Number_of_shots
func change_number_of_shots(number:int=2)->void:
	Number_of_shots-=number
#------------------------------------------
func get_Number_Of_Rounds_Per_Shot()->int:
	return Number_Of_Rounds_Per_Shot
func set_Number_Of_Rounds_Per_Shot(new_Number_Of_Rounds_Per_Shot:int)->void:
	Number_Of_Rounds_Per_Shot=new_Number_Of_Rounds_Per_Shot
#--------------------------------------------------------------




#-------creating and launching Weapon_Elements----------------------------------
func new_Weapon_Element():
	WeaponElement.GetFreeElement()
	Weapon_Element_Initialization(.get_global_mouse_position())
	pass


#calculation of the point of intersection of the trajectories of an asteroid and a bullet (approximate)
func intercept_point(ca) -> Vector2: #вычисление точки пересечения траекторий астероида и пули (примерное)
	return ca.target_center_return() + Vector2(global_position.distance_to(ca.target_center_return())/2/get_Speed()*ca.get_Speed(),
		0).rotated(ca.rotation)
#------------------------------------------
#
func Weapon_Element_Initialization(pos1=null,pos2=null):
	var target_enemy = get_Enemie()
	if target_enemy == null and get_is_shooting_Legal()==null:
		print("Error class BasicWeapon: Weapon_Element_Initialization ")
		#return
	if pos1!=null and pos2==null:
		var new_Weapon_Element1 = WeaponElement.GetFreeElement()
		if new_Weapon_Element1==null:return
		new_Weapon_Element1.position = pos1+Vector2(rand_range(-20,20),rand_range(-20,20))
		if new_Weapon_Element1._get_whether_the_object_is_already_loaded():
			print("new_Weapon_Element1._get_whether_the_object_is_already_loaded() true")
			add_child(new_Weapon_Element1) 
			new_Weapon_Element1._set_whether_the_object_is_already_loaded(true)
			
		#new_Weapon_Element1.set_damage(get_Damage())
		new_Weapon_Element1._Birth_process()
		
		#new_Weapon_Element1.set_Speed(get_Speed())
		#new_Weapon_Element1.set_Direction(intercept_point(target_enemy))

		
	elif pos1!=null and pos2!=null:

		var new_Weapon_Element1 = WeaponElement.GetFreeElement()
		var new_Weapon_Element2 = WeaponElement.GetFreeElement()

		new_Weapon_Element1.position = pos1.global_position
		new_Weapon_Element2.position = pos2.global_position

		new_Weapon_Element1.set_damage(get_Damage())
		new_Weapon_Element2.set_damage(get_Damage())

		new_Weapon_Element1.set_Direction(intercept_point(target_enemy))
		new_Weapon_Element2.set_Direction(intercept_point(target_enemy))

		new_Weapon_Element1.set_Speed(get_Speed())
		new_Weapon_Element2.set_Speed(get_Speed())
		
		if !new_Weapon_Element1._get_whether_the_object_is_already_loaded():
			.add_child(new_Weapon_Element1) 
			#new_Weapon_Element1._set_whether_the_object_is_already_loaded(true)
		
		new_Weapon_Element1._Birth_process()
		
		if !new_Weapon_Element2._get_whether_the_object_is_already_loaded():
			.add_child(new_Weapon_Element2) 
			#new_Weapon_Element2._set_whether_the_object_is_already_loaded(true)

		new_Weapon_Element1._Birth_process()

	else:
		print("Error new Weapon_Element")
#------------------------------------------






#--------------------------------------------------------------
#--------------------------------------------------------------
func get_ID()->int:
	return _ID
func get_Name()->String:
	return Name
#--------------------------------------------------

#--------------------------------------------------
func get_HP_Object()->int:
	return HP_Object
func set_HP_Object(new_HP_Object:int)->void:
	HP_Object=new_HP_Object
#--------------------------------------------------

#--------------------------------------------------
func get_Damage()->float:
	return Damage
func set_Damage(new_Damage:float)->void:
	Damage=new_Damage
func take_damage(damage_done:float)->void:
	var old_hp_obj=get_HP_Object()
	if old_hp_obj>=0:
		var new_Hp=old_hp_obj-damage_done
		set_HP_Object(new_Hp)
#--------------------------------------------------

#--------------------------------------------------
func get_Speed()->float:
	return Speed
func set_Speed(new_Speed:float)->void:
	Speed=new_Speed
#--------------------------------------------------

#--------------------------------------------------
func get_Cooldown()->float:
	return Cooldown
func set_Cooldown(new_Cooldown:float)->void:
	Cooldown=new_Cooldown
#--------------------------------------------------

#--------------------------------------------------
func get_Type()->String:
	return Type_Weapon
#--------------------------------------------------

#--------------------------------------------------
func get_Gold()->int:
	return Gold
func set_Gold(new_Gold:int)->void:
	Gold=new_Gold
#--------------------------------------------------

#--------------------------------------------------
func get_Metal()->int:
	return Metal
func set_Metal(new_Metal:int)->void:
	Metal=new_Metal
#--------------------------------------------------

#--------------------------------------------------
func get_Icon()->String:
	return Icon
#--------------------------------------------------

#--------------------------------------------------
func get_Description()->String:
	return Description
func set_Description(new_Description:String)->void:
	Description=new_Description
#--------------------------------------------------

#--------------------------------------------------
func get_Slowdown()->float:
	return Slowdown
#--------------------------------------------------

#--------------------------------------------------
func get_Weapon_Element()->String:
	return Path_Weapon_Element
#--------------------------------------------------

#--------------------------------------------------
func get_Path_Weapon_Element_is_valid()->bool:
	return _Weapon_Element_path_is_not_valid

func get_Path_Icon_is_valid()->bool:
	return _Icon_path_is_not_valid
#--------------------------------------------------

#--------------------------------------------------


#-------------------------------------------------------------------------------
func _on_Is_colliding_Planet_area(_area, _is_colliding):
	_set_is_colliding_Planet(_is_colliding)
func _on_Is_colliding_Weapons_area(_area, _is_colliding):
	_set_is_colliding_Weapons(_is_colliding)
#-------------------------------------------------------------------------------



func _on_BasicWeapon_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		new_Weapon_Element()
#------------------------------------------
	
	pass # Replace with function body.
