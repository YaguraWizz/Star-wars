extends Area2D
class_name BasicPlanet

#--------------------------------------------------------------
export var _ID:int
export var Icon:String
export var Name:String 
export var HP_BasicPlanet:int 
export var MAX_HP_BasicPlanet:int 
export var Speed:float 
export var Gold:int  
export var Metal:int 
export var Description:String
export var Level:int
#--------------------------------------------------------------
var _Icon_path_is_not_valid:bool=false
#--------------------------------------------------------------
onready var _Icon = $Icon
onready var animation_BasicPlanet = $AnimationPlayer

#--------------------------------------------------------------
func _init(ID:int=0,_Name:String="BasicPlanet",_HP_BasicPlanet:int=10000,_MAX_HP_BasicPlanet:int=10000,_Speed:float=0.5,_Gold:float=0,_Metal:float=0,_Level:int=1,_Description:String="",_Path_Icon:String=""):
#--------------------------#validation of paths#--------------------------------
	if !_Path_Icon.is_abs_path():
		_Icon_path_is_not_valid=true
		print("Error class Info_The_Object: _Path_Weapon_Element is not a path")
	else:
		_Icon.set_texture(load(_Path_Icon))
#-------------------------------------------------------------------------------
	_ID=ID
	Name=_Name
	HP_BasicPlanet=_HP_BasicPlanet
	MAX_HP_BasicPlanet=_MAX_HP_BasicPlanet
	Speed=_Speed
	Gold=_Gold
	Metal=_Metal
	Description=_Description
	Level=_Level
#--------------------------------------------------------------

#--------------------------------------------------------------
func get_ID()->int:
	return _ID
func get_Name()->String:
	return Name
#--------------------------------------------------

#--------------------------------------------------
func take_damag(damage_done:float)->void:
	var now_hp=int(get_HP_BasicPlanet()-damage_done)
	if now_hp>=0:
		set_HP_BasicPlanet(now_hp)
	else:
		animation_BasicPlanet.stop(true)
		_Death_process()
func set_HP_BasicPlanet(new_hp:int)->void:
	HP_BasicPlanet=new_hp
func get_HP_BasicPlanet()->int:
	return HP_BasicPlanet
func get_MAX_HP_BasicPlanet()->int:
	return HP_BasicPlanet
#--------------------------------------------------


#-------------------------------------------------------------------------------
func _Birth_process():
	pass
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
func _Life_process():
	pass
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
func _Death_process():
	pass
#-------------------------------------------------------------------------------


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
func get_Icon()->String:
	return Icon
#--------------------------------------------------

#--------------------------------------------------
func get_Description()->String:
	return Description
#--------------------------------------------------

func _on_BasicPlanet_ready():
	_Birth_process()
	pass # Replace with function body.
