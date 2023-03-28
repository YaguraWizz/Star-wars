extends Area2D
class_name BassicBullet

export var damage:float


var velocity:Vector2
var Direction:Vector2
var Speed:float
var move:bool=false

func _ready():
	if get_Direction()!=null:
		look_at(get_Direction())
		set_velocity()

#-----------------------------------------------------
func set_Direction(_Direction:Vector2)->void:
	if _Direction!=null:
		Direction=_Direction

func get_Direction()->Vector2:
	return Direction
#-----------------------------------------------------

#-----------------------------------------------------
func set_Speed(_Speed:float=0)->void:
	if _Speed!=0:
		Speed=_Speed

func get_Speed()->float:
	return Speed
#-----------------------------------------------------

#-----------------------------------------------------
func set_velocity()->void:
	if Speed!=null:
		velocity = Vector2(get_Speed(), 0).rotated(rotation)
		move=true
#-----------------------------------------------------

#-----------bullet flight-----------------------------
func bullet_flight():
	if move:
		global_position += velocity
#-----------------------------------------------------

#-----------------------------------------------------
func set_damage(_damage:float)->void:
	if _damage>=0:damage=_damage
	
func get_damage()->float:
	return damage
#-----------------------------------------------------

#-----------------------------------------------------
func queue_free_bullit():
	queue_free()
#-----------------------------------------------------

func _on_Bullet_area_entered(area):
	if area.oneshot:
		area.take_damage(damage)
		queue_free_bullit()
func _on_VisibilityNotifier2D_screen_exited():
		queue_free()


