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
onready var collision_shape_2d = $CollisionShape2D
onready var enemies = $Enemies
onready var explosion = $Explosion
onready var animation_player = $AnimationPlayer

#-------------------------------------------------------------------------------
onready var AnimDedAsteroid:= preload("res://GameFile/EndlessWaves/Enemies/Asteroid/Anim_ded_asteroid.tscn")
#-------------------------------------------------------------------------------


#--------Technical Fields-------------------------------------------------------
export var spawn_id:int = 0
export var is_it_visible:bool=false
export var is_the_scene_loaded:bool=false
var is_dead:bool=false
#-------------------------------------------------------------------------------

#--------Object Physics---------------------------------------------------------
var velocity:Vector2
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

#--------------------------------------------------отвечают за pool 
func setActive(stat:bool)->void:
	is_it_visible=stat
func getActive()->bool:
	return is_it_visible
#--------------------------------------------------отвечают за то что был ли объект уже добавлен или это новый
func _set_is_the_scene_loaded(_is_the_scene_loaded:bool)->void:
	is_the_scene_loaded=_is_the_scene_loaded
func _get_is_the_scene_loaded()->bool:
	return is_the_scene_loaded
#--------------------------------------------------отвечают за жизнь объекта
func _set_is_dead_Enemies(_is_dead_Enemies:bool)->void:
	is_dead=_is_dead_Enemies
func _get_is_dead_Enemies()->bool:
	return is_dead
#--------------------------------------------------
func _Object_State(Object_State:bool=true)->void:
	#enemies.set_visible(Object_State)
	#explosion.set_visible(Object_State)
	pass
#--------------------------------------------------
func _physics_process(_delta):
	Moving_Enemies()
#--------------------------------------------------

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
	if get_HP_Enemies()>0 and !is_dead:
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
func set_HP_Enemies(_HP_Enemies:int=0)->void:
	HP_Enemies=_HP_Enemies
	if HP_Enemies<=0 and _HP_Enemies!=0 :
		
		_set_is_dead_Enemies(true)
		Animation_Asteroid_is_dead()
func get_HP_Enemies()->int:
	return HP_Enemies
#--------------------------------------------------


#-----Weapon Damage--------------------------------
func _on_BassicEnemies_area_entered(area):
	if area.is_in_group("PLANET") and !is_dead:
		area.take_damage(get_Damag())
		_set_is_dead_Enemies(true)
		Animation_Asteroid_is_dead()
	pass # Replace with function body.
#--------------------------------------------------

#-----Damage To The Planet-------------------------
func _on_BassicEnemies_body_entered(_body):
	if get_HP_Enemies()<=0 or !is_dead:return
	pass # Replace with function body.
#--------------------------------------------------


#--------------------------------------------------
func Animation_Asteroid_is_dead()->void:
	Globals.Skaner.clear_target_array(self,"planet")
	_Object_State(false)
	animation_player.play("Explosion")
	get_tree().call_group("Bar","update_Metal",Gold)
	get_tree().call_group("Bar","update_gold",Metal)
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name=="Explosion":
		hide()
		setActive(false)
#--------------------------------------------------

#--------------------------------------------------
func Moving_Enemies()->void:
	if _get_is_dead_Enemies():return
	look_at(Globals.Planets.global_position)
	velocity = global_position.direction_to(Globals.Planets.global_position) * get_Speed()
	translate(velocity)
	pass
#--------------------------------------------------

#--------------------------------------------------
func target_center_return()->Vector2:
	return head_position.global_position
#--------------------------------------------------

func up_date_live()->void:
	show()
	set_HP_Enemies(40)
	_set_is_dead_Enemies(false)
	print("\nold_get_HP_Enemies() ",HP_Enemies)
	print("new_get_HP_Enemies(40) ",HP_Enemies)
