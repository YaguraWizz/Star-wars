extends BasicDefenders
class_name BasicGroundWeapons

#-------------------------------------------------------------------------------
#СВОЙСТВА ПУШЕК
export var Damage:float=0.0 setget set_Damage, get_Damage
export var Cooldown:float=0.0 setget set_Cooldown, get_Cooldown
export var TypeOfWeapons:String setget set_TypeOfWeapons, get_TypeOfWeapons
var DamagePerSecond:float=0.0 setget , get_Damage_per_second
#-------------------------------------------------------------------------------
#КОНСТАНТА ДЛЯ match 
enum NUM_PER_SHOT {ONE=1, TWO=2 }
#-------------------------------------------------------------------------------
#ПОЛЯ ДЛЯ ЛОГИКЕ СТРЕЛЬБЫ
var Enemie:Object
var Number_Of_Rounds_Per_Shot:int=1
var Number_of_shots:int=0
var _Timer:float=0.0
var is_shooting_Legal:bool=false
onready var Dictionary_Of_GlobalNodePositions:Dictionary={}
#-------------------------------------------------------------------------------
#POOL BULLET
onready var PoolWeaponElement:BassicPool
#-------------------------------------------------------------------------------
#ПОЛЯ ДЛЯ УПРАВЛЕНИЯ ПЕРЕМЕЩЕНИЕМ ИЛИ ВЫЗОВОМ ПАНЕЛИ ИНФОРМАЦИИ
var is_dragMouse = false
var is_colliding_Planet = false
var is_colliding_Weapons = false
var is_Active_Info_Panel:bool=false
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
func _ready():
	print("ready of name BasicWeapon:"+ $".".get_name())
	add_to_group("BasicGroundWeapons")
	set_Damage_per_second()
	set_Dictionary_Of_GlobalNodePositions()
	set_pool()
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
#ВАЖНО ПОЭТОМУ СВЕРХУ
func set_pool()->void:
	var tempPool=Global.PLANET.get_IDS().get_pool()
	print(tempPool.GetFreeElement().get_name())
	if tempPool!=null:
		PoolWeaponElement=tempPool
	else:
		print("BasicGroundWeapons: pool transfer error")
func set_Dictionary_Of_GlobalNodePositions()->void:
	if get_node_or_null("Position1"):
		Dictionary_Of_GlobalNodePositions[0]=get_node("Position1")
	else:
		print($".".get_name()+" has no node position 1")
		return
	if get_node_or_null("Position2"):
		Dictionary_Of_GlobalNodePositions[1]=get_node("Position2")
	else:
		print($".".get_name()+" has no node position 2")
		return
func get_Dictionary_Of_GlobalNodePositions()->Dictionary:
	return Dictionary_Of_GlobalNodePositions
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
#ФЛАГИ РАЗРЕЩЕНИЙ У ПУШЕК
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
func set_is_shooting_Legal(new_shooting_value: bool) -> void:
	is_shooting_Legal = new_shooting_value
func get_is_shooting_Legal() -> bool:
	return is_shooting_Legal
#-------------------------------------------------------------------------------
#права на установку, отображение информации,стрельбу
func _is_There_Permission_ToDisplayInformation()->bool:
	if !_get_is_dragMouse() and _get_is_colliding_Planet() and !_get_is_colliding_Weapons() :
		return true
	else:
		return false
func _is_There_Permission_ToInstall()->bool:
	if _get_is_dragMouse() and _get_is_colliding_Planet() and !_get_is_colliding_Weapons():
		return true
	else:
		return false
func _doYouHave_Permission_ToShoot() -> bool:
#	print("-----------------------")
#	print("!_get_is_dragMouse() ",!_get_is_dragMouse())
#	print("_get_is_colliding_Planet() ",_get_is_colliding_Planet())
#	print("!_get_is_colliding_Weapons() ",!_get_is_colliding_Weapons())
#	print("get_is_shooting_Legal() ",get_is_shooting_Legal())
#	print("get_Enemie() ",get_Enemie())
#	#print("_doYouHave_Permission_ToShoot()",!_get_is_dragMouse() and _get_is_colliding_Planet() and !_get_is_colliding_Weapons() and get_is_shooting_Legal() and get_Enemie() != null)
#	print("-----------------------")
	if !_get_is_dragMouse() and _get_is_colliding_Planet() and !_get_is_colliding_Weapons() and get_is_shooting_Legal() and get_Enemie() != null:
		return true
	else:
		return false
#-------------------------------------------------------------------------------



#-------------------------------------------------------------------------------
func set_Damage(new_Damage:float)->void:
	Damage=new_Damage
func get_Damage()->float:
	return Damage
#--------------------------------------------------
#--------------------------------------------------
func set_Cooldown(new_Cooldown:float)->void:
	Cooldown=new_Cooldown
func get_Cooldown()->float:
	return Cooldown
#--------------------------------------------------
#----------Damage_per_second()---------------------
func set_Damage_per_second()->void:
	if get_Cooldown()==0 or get_Damage()==0:return
	DamagePerSecond=stepify(float(get_Damage()/get_Cooldown()),0.01)
func get_Damage_per_second()->float:
	set_Damage_per_second()
	return DamagePerSecond
#--------------------------------------------------
#--------------------------------------------------
func set_TypeOfWeapons(Type:String)->void:
	TypeOfWeapons=Type
func get_TypeOfWeapons()->String:
	return TypeOfWeapons
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
func _StartingWeaponSetup(_Object):
#----------BASIC DEFENDERS------------------------------------------------------
	.set_ID(_Object.get_ID())
	.set_Path_Icon(_Object.get_Path_Icon())
	.set_Path_Sounds(_Object.get_Path_Sounds())
	.set_Name(_Object.get_Name())
	.set_Speed(_Object.get_Speed())
	.set_Gold(_Object.get_Gold())
	.set_Metal(_Object.get_Metal())
	.set_Description(_Object.get_Description())
#----------BASIC GROUND WEAPONS-------------------------------------------------
	set_Damage(_Object.get_Damage())
	set_Cooldown(_Object.get_Cooldown())
	set_TypeOfWeapons(_Object.get_Type_Weapon())
	#Slowdown=_Object.get_Slowdown()
	#СДЕЛАТЬ ФУНКИЮ ПО ПЕРЕДАЧИ ТИПА ПУЛЬ 
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
func _physics_process(delta):
	_Fire_on_the_Enemy(delta)
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
func _Fire_on_the_Enemy(delta)->void:
	if _doYouHave_Permission_ToShoot():
		time_change(delta)
		if get_Timer()>get_Cooldown() and get_number_of_shots()>0:
			print("level2")
			look_at(get_Enemie_global_position())
			Weapon_Element_Initialization()
			change_number_of_shots(get_Dictionary_Of_GlobalNodePositions().size())
			set_Timer(0)
#-------------------------------------------------------------------------------












#-------------------------------------------------------------------------------
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
	return Enemie.get_ID()		
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
	Number_of_shots=stepify((_Enemie.get_EnemiesHP() * (3/(get_Number_Of_Rounds_Per_Shot()*get_Damage()))),1) as int
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
#--------------------------------------------------------------
#-----------time-between-shots-------------
func set_Timer(_timer:float)->void:
	if _timer>=0:_Timer=_timer
func get_Timer()->float:
	return _Timer
func time_change(_timer:float)->void:
	_Timer+=_timer
#------------------------------------------
#--------------------------------------------------------------
#--------------------------------------------------------------


#-----------------------------------------------------------------------------------------------------------------------------
func Weapon_Element_Initialization():
	if get_Dictionary_Of_GlobalNodePositions()[0]==null:
		print(" Error class BasicWeapon: .Weapon_Element_Initialization: pos is null ")
		return null
	var target_enemy = get_Enemie()
	if target_enemy == null:
		print("Error class BasicWeapon: .Weapon_Element_Initialization: get_Enemie()  return is null")
		return null

	match get_Dictionary_Of_GlobalNodePositions().size():
		NUM_PER_SHOT.ONE:
			var New_Weapon_Element_One = PoolWeaponElement.GetFreeElement()
			if New_Weapon_Element_One==null:
				print("Error class BasicWeapon: .Weapon_Element_Initialization: PoolWeaponElement.GetFreeElement()  return is null")
				return null
			else:
				New_Weapon_Element_One.set_position(get_Dictionary_Of_GlobalNodePositions()[0].global_position)
				New_Weapon_Element_One.set_position(global_position)
				look_at(get_global_mouse_position())
				#Set_New_Weapon_Element_Parameters(New_Weapon_Element_One,.get_global_mouse_position())
				Set_New_Weapon_Element_Parameters(New_Weapon_Element_One,target_enemy)
				if New_Weapon_Element_One.get_parent()==null:
					get_tree().get_node("MyPool").add_child(New_Weapon_Element_One) 
				New_Weapon_Element_One._Birth_process()

		NUM_PER_SHOT.TWO:
			pass
			var New_Weapon_Element_One = PoolWeaponElement.GetFreeElement()
			var New_Weapon_Element_Two = PoolWeaponElement.GetFreeElement()

			if New_Weapon_Element_One==null or New_Weapon_Element_Two==null:
				print("Error class BasicWeapon: .Weapon_Element_Initialization: PoolWeaponElement.GetFreeElement()  return is null")
				return null
			else:
				Set_New_Weapon_Element_Parameters(New_Weapon_Element_One,target_enemy)
				Set_New_Weapon_Element_Parameters(New_Weapon_Element_Two,target_enemy)

				New_Weapon_Element_One.set_position(get_Dictionary_Of_GlobalNodePositions()[0].global_position)
				New_Weapon_Element_Two.set_position(get_Dictionary_Of_GlobalNodePositions()[1].global_position)

				if New_Weapon_Element_One.get_parent()==null:
					get_node("MyPool").add_child(New_Weapon_Element_One) 
				if New_Weapon_Element_One.get_parent()==null:
					get_node("MyPool").add_child(New_Weapon_Element_One) 

				New_Weapon_Element_One._Birth_process()
				New_Weapon_Element_One._Birth_process()

		_: 
			print(" Error class BasicWeapon: .Weapon_Element_Initialization: match Number_Of_Rounds_Per_Shot is call default ")
			return null
#------------------------------------------------------------------------------------------------------------------------------

func Set_New_Weapon_Element_Parameters(NEW_WEAPON_ELEMENT:Object,TARGET_ENEMY)->void:
	NEW_WEAPON_ELEMENT.set_Damag(get_Damage())
	NEW_WEAPON_ELEMENT.set_Speed(.get_Speed())
	NEW_WEAPON_ELEMENT.set_Destination(intercept_point(TARGET_ENEMY))
	#NEW_WEAPON_ELEMENT.set_Destination(TARGET_ENEMY)
	pass
	
#calculation of the point of intersection of the trajectories of an asteroid and a bullet (approximate)
func intercept_point(ca) -> Vector2: #вычисление точки пересечения траекторий астероида и пули (примерное)
	return ca.global_position + Vector2(global_position.distance_to(ca.global_position)/2/get_Speed()*ca.get_Speed(),
		0).rotated(ca.rotation)


#-------------------------------------------------------------------------------
func _on_Is_colliding_Planet_area(_area, _is_colliding):
	if _area.is_in_group("PLANET"):
		_set_is_colliding_Planet(_is_colliding)
func _on_Is_colliding_Weapons_area(_area, _is_colliding):
	if _area.is_in_group("BasicGroundWeapons"):
		_set_is_colliding_Weapons(_is_colliding)
#-------------------------------------------------------------------------------

func _on_BasicWeapon_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		#new_Weapon_Element()
		pass
#------------------------------------------

#func _on_BasicWeapon_ready():
#	set_Icon(Icon)
#	set_Sounds(Sounds)
##--------------------------------------------------
#func get_Slowdown()->float:
#	return Slowdown
##--------------------------------------------------

#export var Slowdown:float=0.0 сделать в наследнике лазер
#-------------------------------------------------------------------------------
#onready var PoolWeaponElement=WeaponElementPool.new('res://Weapons/Weapon_Element/BasicWeaponElement.tscn',1)
