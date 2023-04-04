extends Area2D
class_name BasicDefenders
#-------------------------------------------------------------------------------
export var ID:int=0 setget set_ID, get_ID
#---------About_Weapons---------------------------------------------------------
export var Icon:String setget set_Path_Icon, get_Path_Icon
export var Name:String setget set_Name, get_Name
export var Level:int=1 setget Level_up, get_Level
export var Speed:float=0.0 setget set_Speed, get_Speed
export var Gold:int=0 setget set_Gold, get_Gold
export var Metal:int=0 setget set_Metal, get_Metal
export var Description:String setget set_Description, get_Description
export var Sounds:String setget set_Path_Sounds, get_Path_Sounds
#-------------------------------------------------------------------------------
var IBootedUp=false setget , _get_IBootedUp
#-------------------------------------------------------------------------------
func _ready():
	IBootedUp=true
#-------------------------------------------------------------------------------
func _get_IBootedUp()->bool:
	return IBootedUp
#-------------------------------------------------------------------------------
func get_ID()->int:
	return ID
func set_ID(new_ID:int)->void:
	ID=new_ID
#------------------------------------------
#------------------------------------------
func set_Path_Icon(_Path_Icon:String)->void:
	if _Path_Icon.is_abs_path() and _get_IBootedUp():
		Icon=_Path_Icon
		set_Icon(Icon)
	else:
		#print("Error path Icon ",self.get_name())
		pass
func get_Path_Icon()->String:
	return Icon
func set_Icon(_new_Icon:String)->void:
	pass
#------------------------------------------
#-----------Name()-------------------------
func set_Name(_Name:String="default")->void:
	if _Name=="":return
	Name=_Name
func get_Name()->String:
	return Name
#------------------------------------------
#------------------------------------------
func get_Level()->int:
	return Level
func Level_up(_plug:int)->void:
	pass
func update_level()->void:
	Level+=1
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
		set_Icon(Sounds)
	else:
		print("Error path Icon ",self.get_name())
func get_Path_Sounds()->String:
	return Sounds
func set_Sounds(_new_Sounds:String)->void:
	pass
#------------------------------------------

