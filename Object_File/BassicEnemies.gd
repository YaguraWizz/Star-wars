extends Area2D
class_name BassicEnemies
#--------------------------------------------------------------
export var _ID:int
export var Icon:String
export var Name:String 
export var HP_Object:int 
export var Damage:float 
export var Speed:float 
export var Gold:int  
export var Metal:int 
export var Description:String
export var Path_Object:String
export var Level:int
#--------------------------------------------------------------
export var Cooldown:float
export var Type_Object:String
export var Slowdown:float
export var Path_Weapon_Element:String
#--------------------------------------------------------------
var _Object_path_is_not_valid:bool=false
var _Weapon_Element_path_is_not_valid:bool=false
var _Icon_path_is_not_valid:bool=false
#--------------------------------------------------------------

##--------------------------------------------------------------
#func _init(ID:int,_Name:String,_Type:String,_HP_Object:int,_Damage:float,_Speed:float,_Gold:float,_Metal:float,_Description:String,_Path_Object:String,_Path_Icon:String,_Path_Weapon_Element:String="",_Cooldown:float=0,_Slowdown:float=0,_Level:int=1):
#
##--------------------------#validation of paths#--------------------------------
#	if !_Path_Object.is_abs_path():
#		_Object_path_is_not_valid=true
#		print("Error class Info_The_Object: _Path_Object is not a path")
#	if !_Path_Weapon_Element.is_abs_path():
#		_Weapon_Element_path_is_not_valid=true
#		print("Error class Info_The_Object: _Path_Weapon_Element is not a path")
#	if !_Path_Icon.is_abs_path():
#		_Icon_path_is_not_valid=true
#		print("Error class Info_The_Object: _Path_Weapon_Element is not a path")
##-------------------------------------------------------------------------------
#	_ID=ID
#	Name=_Name
#	HP_Object=_HP_Object
#	Damage=_Damage
#	Speed=_Speed
#	Gold=_Gold
#	Metal=_Metal
#	Description=_Description
#	if _Cooldown!=0:
#		Cooldown=_Cooldown
#		Slowdown=_Slowdown
#		Type_Object=_Type
#		Level=_Level
#		Path_Weapon_Element=_Path_Weapon_Element
##--------------------------------------------------------------

#--------------------------------------------------------------
func get_ID()->int:
	return _ID
func get_Name()->String:
	return Name
#--------------------------------------------------

#--------------------------------------------------
func get_HP_Object()->int:
	return HP_Object
#--------------------------------------------------

#--------------------------------------------------
func get_Damage()->float:
	return Damage
#--------------------------------------------------

#--------------------------------------------------
func get_Speed()->float:
	return Speed
#--------------------------------------------------

#--------------------------------------------------
func get_Cooldown()->float:
	return Cooldown
#--------------------------------------------------

#--------------------------------------------------
func get_Type()->String:
	return Type_Object
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

#--------------------------------------------------
func get_Slowdown()->float:
	return Slowdown
#--------------------------------------------------

#--------------------------------------------------
func get_Weapon_Element()->String:
	return Path_Weapon_Element
	
func get_Path_Weapons()->String:
	return Path_Object
#--------------------------------------------------

#--------------------------------------------------
func get_Path_Object_is_valid()->bool:
	return _Object_path_is_not_valid
	
func get_Path_Weapon_Element_is_valid()->bool:
	return _Weapon_Element_path_is_not_valid

func get_Path_Icon_is_valid()->bool:
	return _Icon_path_is_not_valid
#--------------------------------------------------

#--------------------------------------------------




#--------------------------------------------------
