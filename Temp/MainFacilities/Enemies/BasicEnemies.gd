extends Area2D
class_name BasicEnemies
export var ID:int=0
export var Name:String 
export var Damag:float=0.0
export var Speed:float=0.0 
export var stak_EnemiesHP:int=1 setget set_stak_EnemiesHP
export var Gold:int
export var Metal:int=0 
export var Description:String 
export var Sounds:String
onready var Im_Alive=true
onready var EnemiesHP:int
#-------------------------------------------------------------------------------
var IBootedUp=false setget , _get_IBootedUp
func _get_IBootedUp()->bool:
	return IBootedUp
func _get_Im_Alive()->bool:
	return Im_Alive
#-------------------------------------------------------------------------------
func _ready():
	IBootedUp=true
#-------------------------------------------------------------------------------
#------------------------------------------------
func set_stak_EnemiesHP(new_max_hp:int)->void:
	stak_EnemiesHP=new_max_hp
	set_EnemiesHP(stak_EnemiesHP)
func get_stak_EnemiesHP()->int:
	return stak_EnemiesHP
func set_EnemiesHP(new_hp:int)->void:
	EnemiesHP=new_hp
func get_EnemiesHP()->int:
	return EnemiesHP
func take_damag(damage_taken:int)->void:
	set_EnemiesHP(int(get_EnemiesHP()-damage_taken))
	if get_EnemiesHP()<=0:
		Im_Alive=false
		I_died()
func I_died()->void:
	pass
#------------------------------------------------

func set_Damag(new_Damag:float)->void:
	Damag=new_Damag
func get_Damag()->float:
	return Damag
#--------------------------------------------------


#-------------------------------------------------------------------------------
func get_ID()->int:
	return ID
func set_ID(new_ID:int)->void:
	ID=new_ID
#------------------------------------------

#-----------Name()-------------------------
func set_Name(_Name:String="default")->void:
	if _Name=="":return
	Name=_Name
func get_Name()->String:
	return Name
#------------------------------------------

#------------------------------------------
func set_Speed(_speed:float)->void:
	if _speed>=0:
		Speed=_speed
func get_Speed()->float:
	return Speed
#------------------------------------------

#-------_Gold------------------------------
func set_Gold(_Gold:int=1)->void:
	if _Gold<0:return
	Gold=_Gold
func get_Gold()->int:
	return Gold
#------------------------------------------

#---------_Metal---------------------------
func set_Metal(_Metal:int=1)->void:
	if _Metal<0:return
	Metal=_Metal
func get_Metal()->int:
	return Metal

#----------Description---------------------
func set_Description(_Description:String="default")->void:
	if _Description=="":return
	Description=_Description
func get_Description()->String:
	return Description
#------------------------------------------

#------------------------------------------
func set_Path_Sounds(_Path_Sounds:String)->void:
	if _Path_Sounds.is_abs_path() and _get_IBootedUp():
		Sounds=_Path_Sounds
		set_Sounds(Sounds)
	else:
		print("Error path Icon ",self.get_name())
func get_Path_Sounds()->String:
	return Sounds
func set_Sounds(_new_Sounds:String)->void:
	pass
#------------------------------------------

#------------------------------------------
func set_Icon()->void:
	pass
#------------------------------------------


