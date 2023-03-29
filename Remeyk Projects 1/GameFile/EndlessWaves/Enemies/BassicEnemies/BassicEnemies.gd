extends Area2D
class_name BassicEnemies
#--------Object Fields----------------------------------------------------------
export var Icon:Texture 
export var Name:String 
export var Damag:float 
export var Speed:float 
export var Gold:int  
export var Metal:int 
export var HP_Enemies:int 
#-------------------------------------------------------------------------------
onready var head_position = $Position

#-------------------------------------------------------------------------------
onready var AnimDedAsteroid:= preload("res://GameFile/EndlessWaves/Enemies/Asteroid/Anim_ded_asteroid.tscn")
#-------------------------------------------------------------------------------


#--------Technical Fields-------------------------------------------------------
export var Initial_State:bool=false setget set_Initial_State,get_Initial_State
export var spawn_id:int = 0
export var is_it_visible:bool=false
export var is_the_scene_loaded:bool=false
#-------------------------------------------------------------------------------

#--------Object Physics---------------------------------------------------------
enum Movement_Type {TO_THE_PLANET=0,MAIN_SCREENSAVER=1}
var velocity:Vector2
var is_dead:bool=false
var state=Movement_Type.TO_THE_PLANET
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

func _set_is_dead_Enemies(_is_dead_Enemies:bool)->void:
	is_dead=_is_dead_Enemies
func _get_is_dead_Enemies()->bool:
	return is_dead

func _set_is_the_scene_loaded(_is_the_scene_loaded:bool)->void:
	is_the_scene_loaded=_is_the_scene_loaded
func _get_is_the_scene_loaded()->bool:
	return is_the_scene_loaded
	return is_the_scene_loaded
	
	
func _ready():
	pass


#--------------------------------------------------
func set_Name(_Name:String)->void:
	Name=_Name
func get_Name()->String:
	return Name
#--------------------------------------------------

#--------------------------------------------------
func set_Damag(_Damag:float)->void:
	Damag=_Damag
func get_Damag()->float:
	return Damag
func take_damage(_damage)->void:
	set_HP_Enemies(get_HP_Enemies()-_damage)
func slowdown(_slowdown:float)->void:
	if get_HP_Enemies()>0 and !is_dead:
		set_Speed(_slowdown)
#--------------------------------------------------

#--------------------------------------------------
func set_Speed(_Speed:float)->void:
	Speed=_Speed
func get_Speed()->float:
	return Speed
#--------------------------------------------------

#--------------------------------------------------
func set_Icon(_Icon:Texture)->void:
	Icon=_Icon
func get_Icon()->Texture:
	return Icon
#--------------------------------------------------

#--------------------------------------------------
func set_Gold(_Gold:int)->void:
	Gold=_Gold
func get_Gold()->int:
	return Gold
#--------------------------------------------------

#--------------------------------------------------
func set_Metal(_Metal:int)->void:
	Metal=_Metal
func get_Metal()->int:
	return Metal
#--------------------------------------------------

#--------------------------------------------------
func set_HP_Enemies(_HP_Enemies:int=10)->void:
	HP_Enemies=_HP_Enemies
	if HP_Enemies<=0:
		is_dead=true
		Animation_Asteroid_is_dead()
		Behavior_After_Death()
func get_HP_Enemies()->int:
	return HP_Enemies
#--------------------------------------------------

#--------------------------------------------------
func set_Initial_State(_Initial_State:bool)->void:
	Initial_State=_Initial_State
func get_Initial_State()->bool:
	return Initial_State
#--------------------------------------------------


#-----Weapon Damage--------------------------------
func _on_BassicEnemies_area_entered(area):
	if area.is_in_group("PLANET") and !is_dead:
		Globals.Skaner.clear_target_array(self,"planet")
		area.take_damage(get_Damag())
		_set_is_dead_Enemies(true)
		#queue_free()
	pass # Replace with function body.
#--------------------------------------------------

#-----Damage To The Planet-------------------------
func _on_BassicEnemies_body_entered(_body):
	if get_HP_Enemies()<=0 or !is_dead:return
	pass # Replace with function body.
#--------------------------------------------------
#--------------------------------------------------

func Animation_Asteroid_is_dead()->void:
	if AnimDedAsteroid!=null:
		hide()
		Globals.Skaner.clear_target_array(self,"Weapons")
		var DedAsteroid=AnimDedAsteroid.instance() 
		DedAsteroid.position=global_position
		get_tree().get_root().add_child(DedAsteroid) 

#--------------------------------------------------
#--------------------------------------------------
func Behavior_After_Death()->void:
	pass
#--------------------------------------------------

#-------------------------------------------------------------------------------
func change_Movement_Type(new_state)->void:
	state=new_state
#-------------------------------------------------------------------------------

#--------------------------------------------------
func _physics_process(_delta):
	Moving_Enemies()
	
#--------------------------------------------------
func setActive(stat:bool)->void:
	is_it_visible=stat
func getActive()->bool:
	return is_it_visible
#--------------------------------------------------
func Moving_Enemies()->void:
	if _get_is_dead_Enemies():
		print("_get_is_dead_Enemies() ",_get_is_dead_Enemies())
		return
	match state:
		Movement_Type.TO_THE_PLANET:
			look_at(Globals.Planets.global_position)
			velocity = global_position.direction_to(Globals.Planets.global_position) * get_Speed()
			translate(velocity)
		Movement_Type.MAIN_SCREENSAVER:
			pass
#--------------------------------------------------



func target_center_return()->Vector2:
	return head_position.global_position



