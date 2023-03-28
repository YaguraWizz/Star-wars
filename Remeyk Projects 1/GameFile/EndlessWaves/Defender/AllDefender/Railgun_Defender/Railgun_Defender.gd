extends BassicDefender



onready var Position = .get_node("Position1")

func set_data_filling(Obj)->void:
	.set_preload_bullet(Obj.get_Bullet())
	.set_Speed(Obj.get_Speed())
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

func _physics_process(delta):
	fire_asteroid(delta)

func fire_asteroid(delta) -> void:
	if _get_Attack_Permission_Status():
		.time_change(delta)
		if .get_Timer()>.get_Cooldown()and .get_number_of_shots()>0:
			.look_at(.get_Asteroid_global_position())
			.new_Bullet(Position)
			.change_number_of_shots()
			.set_Timer(0)



