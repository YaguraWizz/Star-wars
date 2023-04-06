extends BasicEnemies
class_name BasicAsteroids
#------------------------------------------------------------------------------
export var TimeLive:int=90
#-------------------------------------------------------------------------------
export var is_it_an_active_object:bool=false
#-------------------------------------------------------------------------------
export var PrefabIcon:Dictionary={
	0 : "res://Images/Enemies/Asteroids/AmberAsteroids.png",
	1 : "res://Images/Enemies/Asteroids/AmethystAsteroids.png",
	2 : "res://Images/Enemies/Asteroids/AzuriteAsteroids.png"
}
#-------------------------------------------------------------------------------
onready var _Timer:Timer = get_node("Timer")
onready var _Animation:AnimationPlayer=get_node("AnimationPlayer")
onready var asteroid_icon = $AsteroidIcon
onready var explosion_icon = $ExplosionIcon
#-------------------------------------------------------------------------------
var Destination:Vector2 
var colision=false
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
func _set_is_it_an_active_object(the_new_activity_state_of_the_object:bool)->void:
	is_it_an_active_object=the_new_activity_state_of_the_object
func _get_is_it_an_active_object()->bool:
	return is_it_an_active_object
#-------------------------------------------------------------------------------
func _ready():
	set_Icon()
	_Animation.play("Flight")
#-------------------------------------------------------------------------------
func _Birth_process():
	show()
	set_Icon()
	.set_EnemiesHP(.get_stak_EnemiesHP())
	asteroid_icon.show()
	explosion_icon.hide()
	_Timer.set_wait_time(TimeLive)
	_Timer.start()
	_Animation.play("Flight")
	colision=false
	pass
#-------------------------------------------------------------------------------
func set_Icon()->void:
	var rang_type=randi()%PrefabIcon.size()
	var new_Icon=load(PrefabIcon[rang_type])
	asteroid_icon.set_texture(new_Icon)
#-------------------------------------------------------------------------------
func _process(delta):
	if _get_is_it_an_active_object() and !colision and ._get_Im_Alive():
		look_at(Destination)
		move_to_destination(Destination,delta)

	pass
#-------------------------------------------------------------------------------
func move_to_destination(_Destination,_delta):
	var direction = (_Destination - position).normalized()
	position += direction * get_Speed() * _delta
#-------------------------------------------------------------------------------
func _Death_process():
	asteroid_icon.hide()
	explosion_icon.show()
	_Animation.play("Explosion")
	Global.PLANET.get_IDS().clear_target_array(self,"ded")
	pass
#-------------------------------------------------------------------------------


#--------------------------------------------------
func _on_BasicAsteroids_area_entered(area):
	if area==Global.PLANET:
		colision=true
		area.take_damag(.get_Damag())
		_Death_process()
#--------------------------------------------------

#--------------------------------------------------
func _on_Timer_timeout():
	hide()
	_Timer.stop()
	_set_is_it_an_active_object(false)
	_Death_process()
#-------------------------------------------------
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name=="Explosion":
		_set_is_it_an_active_object(false)
		hide()
	pass # Replace with function body.



