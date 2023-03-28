extends BassicDefender

onready var l = .get_node("AntialiasedLine2D")
var _damag:float=0
var mnoz=3
var dem=0

func set_data_filling(Obj)->void:
	_damag=Obj.get_Damage()
	.set_Timer(0)
#---------------------------------------------------------
	.set_Icon(Obj.get_Texture())
	.set_Name(Obj.get_Name())
	.set_Damage(Obj.get_Damage())
	.set_Cooldown(Obj.get_Cooldown())
	.set_TypeOfDamage(Obj.get_Type())
	.set_Description(Obj.get_Description())
	.set_Damage_per_second()
	.set_Gold(Obj.get_Gold())
	.set_Metal(Obj.get_Metal())
	pass

func _physics_process(_delta:float):
	if _get_Attack_Permission_Status():
		.look_at(.get_Asteroid().target_center_return())
		l.points[1] = .to_local(.get_Asteroid().target_center_return())
		l.show()
		.time_change(_delta)
		if .get_Timer()>get_Cooldown():
			dem += _damag*mnoz
			.get_Asteroid().take_damage(dem)
			.set_Timer(0)
			.change_number_of_shots(0)
	else:
		dem=0
		l.hide()



