extends Area2D

class_name BasicWeaponElement
#-------------------------------------------------------------------------------
export var _ID:int
export var TimeLive:int=3
#-------------------------------------------------------------------------------
export var is_it_an_active_object:bool=false
#export var whether_the_object_is_already_loaded:bool=false
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
export var Damage:float 
export var Speed:float 
#-------------------------------------------------------------------------------
onready var timer:Timer = $Timer
onready var color_rect = $ColorRect

#-------------------------------------------------------------------------------
var Direction:Vector2 
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
func _set_is_it_an_active_object(the_new_activity_state_of_the_object:bool)->void:
	
	is_it_an_active_object=the_new_activity_state_of_the_object
func _get_is_it_an_active_object()->bool:
	return is_it_an_active_object
#func _set_whether_the_object_is_already_loaded(the_new_activity_state_of_the_object:bool)->void:
#	print("old ",is_it_an_active_object," b ",the_new_activity_state_of_the_object)
#	is_it_an_active_object=the_new_activity_state_of_the_object
#func _get_whether_the_object_is_already_loaded()->bool:
#	return is_it_an_active_object
#-------------------------------------------------------------------------------
func _ready():
	print("\n\nin ready of name "+ $".".get_name())

#-------------------------------------------------------------------------------
func _Birth_process():
	show()
	color_rect.set_frame_color(Color(rand_range(0,1),rand_range(0,1),rand_range(0,1),1))
	timer.set_wait_time(TimeLive)
	print("timer.get_wait_time() ",timer.get_wait_time())
	timer.start()
	pass
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
func _process(delta):
	if _get_is_it_an_active_object():
		global_position += Direction*delta
	pass
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
func _Death_process():
	hide()
	_set_is_it_an_active_object(false)
	pass
#-------------------------------------------------------------------------------


#--------------------------------------------------
func get_ID()->int:
	return _ID
#--------------------------------------------------

#--------------------------------------------------
func set_Direction(_Direction:Vector2)->void:
	if _Direction!=null:
		Direction=_Direction
func get_Direction()->Vector2:
	return Direction
#--------------------------------------------------

#--------------------------------------------------
func get_Damage()->float:
	return Damage
func set_Damage(new_Damage:float)->void:
	Damage=new_Damage
#--------------------------------------------------

#--------------------------------------------------
func get_Speed()->float:
	return Speed
func set_Speed(new_Speed:float)->void:
	Speed=new_Speed
#--------------------------------------------------

#--------------------------------------------------
func _on_BasicWeaponElement_area(_area):
	_Death_process()
	pass # Replace with function body.
#--------------------------------------------------

#--------------------------------------------------
func _on_Timer_timeout():
	print("timer out ")
	timer.stop()
	_Death_process()
	pass # Replace with function body.
#-------------------------------------------------
func _on_BasicWeaponElement_ready():
	print(" I'm ready")
	#_set_whether_the_object_is_already_loaded(true)
	pass # Replace with function body.
