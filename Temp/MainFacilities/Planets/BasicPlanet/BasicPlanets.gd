extends Area2D
class_name BasicPlanets

#---------About_Weapons---------------------------
export var ID:int
export var Name:String 
export var Icon:String setget set_Path_Icon,get_Path_Icon
export var Speed:float=1
export var HP_Planet:int 
export var max_HP_Planet:int
export var Description:String 
#-------------------------------------------------
var angular_speed = PI
var IBootedUp=false setget , _get_IBootedUp
#-------------------------------------------------

#--------------------------------------------------------------
func _ready():
	print("ready of name BasicPlanets:"+ $".".get_name())
	Global.PLANET=self
	IBootedUp=true
#--------------------------------------------------------------
func _process(delta):
	rotation_degrees += angular_speed * delta * Speed
#--------------------------------------------------------------

#------------------------------------------------
func _get_IBootedUp()->bool:
	return IBootedUp
#------------------------------------------------
#------------------------------------------------

#------------------------------------------------
#------------------------------------------------
func get_ID()->int:
	return ID
#------------------------------------------------
func set_Path_Icon(_Path_Icon:String)->void:
	if _Path_Icon.is_abs_path() and _get_IBootedUp():
		Icon=_Path_Icon
		get_node("Sprite").set_texture(load(Icon))
	else:
		#print("Error path Icon ",self.get_name())
		pass
func get_Path_Icon()->String:
	return Icon
#------------------------------------------------

#------------------------------------------------
func set_Max_HP_Planet(new_max_hp:int)->void:
	max_HP_Planet=new_max_hp
func get_Max_HP_Planet()->int:
	return max_HP_Planet
func set_HP_Planet(new_hp:int)->void:
	HP_Planet=new_hp
func get_HP_Planet()->int:
	return HP_Planet
func take_damag(damage_taken:int)->void:
	set_HP_Planet(int(get_HP_Planet()-damage_taken))
#------------------------------------------------

#------------------------------------------------
func set_Speed(_speed:float)->void:
	if _speed>=0:
		Speed=_speed
func get_Speed()->float:
	return Speed
#------------------------------------------------

#------------------------------------------------
func set_Name(_Name:String="default")->void:
	if _Name=="":return
	Name=_Name
func get_Name()->String:
	return Name
#------------------------------------------------

#------------------------------------------------
func set_Description(_Description:String="default")->void:
	if _Description=="":return
	Description=_Description
func get_Description()->String:
	return Description
#------------------------------------------------
func get_IDS()->Object:
	return get_node_or_null("IntrusionDetectionSystem")
