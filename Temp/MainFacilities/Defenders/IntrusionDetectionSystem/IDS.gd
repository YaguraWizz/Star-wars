extends BasicDefenders
class_name IntrusionDetectionSystem
export  var Radius:float setget set_radius
export  var max_radius:float=10
export  var StepRadius:float=10
export  var CoefficientLevelUP:float=3.0/2
onready var target_Enemy:Dictionary = {}
onready var sprite = get_node("Icon")
onready var PrefabBullet:String="res://MainFacilities/Defenders/GroundForce/GroundGuns/BasicBullet/BasicBullet.tscn"
onready var StartingNumberOfBullets:int=10
onready var poolBullet:BassicPool
#-------------------------------------------------------------------------------
func _ready():
	Global.IDS=self
	print("ready of name BasicWeapon:"+ $".".get_name())
	poolBullet=BassicPool.new(PrefabBullet,StartingNumberOfBullets)
	poolBullet.AutoExpand=true
	Global.IDSBullet=poolBullet
	print("IntrusionDetectionSystem: pool name ",poolBullet.GetFreeElement().get_name()," ID ",poolBullet.ID)
	for i in poolBullet.get_size_pool():
		print("poolBullet ",poolBullet.pool[i])
#	print("Pool size Bullet ",poolBullet.get_size_pool())
#-----LEVEL_UP------------------------------------------------------------------
func Level_up(_plug:int)->void:
	if !_get_IBootedUp():return
	var now_radius=get_radius()+StepRadius
	if now_radius<max_radius:
		set_radius(now_radius)
		.update_level()
		.set_Gold(int(.get_Gold()*CoefficientLevelUP))
		.set_Metal(int(.get_Metal()*CoefficientLevelUP))
	else:
		print("max_level")
	pass
func set_radius(new_radius)->void:
	if !._get_IBootedUp():return
	var collision_shape = get_node("CollisionShape2D")
	# Создаем новый CircleShape2D с заданным радиусом
	var circle_shape = CircleShape2D.new()
	circle_shape.radius = new_radius
	# Устанавливаем CircleShape2D как физическую форму объекта
	collision_shape.shape = circle_shape
func get_radius()->float:
	#Получаем CollisionShape2D объекта
	var collision_shape = get_node("CollisionShape2D")
	# Получаем CircleShape2D из физической формы объекта
	var circle_shape = collision_shape.shape as CircleShape2D
	# Получаем радиус круга
	Radius = circle_shape.radius
	#print("Радиус круга:", Radius)
	return Radius
	# Получаем CollisionShape2D объекта
#-------------------------------------------------------------------------------
func set_Icon(new_Icon:String)->void:
	sprite.set_texture(load(new_Icon))
#-------------------------------------------------------------------------------
func _process(delta):
	sprite.rotation+=delta*.get_Speed()
	_fire_Weapons()
#---------------TRANSFER OF THE ENEMY TO THE DEFENDERS--------------------------
func _fire_Weapons()->void:
	var guns = _get_available_guns()
	# если нет свободных пушек, то ничего не сделать
	if guns.size() < 1:
		return
		
	var targets = _validate_targets()
	# если целей нет то ничего не делаем
	if targets.size() < 1:
		return
	
	var target_index = 0
	# смотрим на готовые стрелять пушки
	for gun in guns:
		var target = targets[target_index]
		#
		if target_index + 1 < targets.size():
			target_index += 1
			
		# цель нашлаcь, стреляем
		gun.set_Enemie(target)
		
	return
func _on_IDS_area_entered(area)->void:
	target_Enemy[area.ID] = area
	#print("Scanner_area Weapon count ", get_tree().get_nodes_in_group("Weapon").size())
	print("area.ID: ", area.ID)
func clear_target_array(dead_asteroid,_strr:String)->void:
	# убрать мертвый астероид из листа обнаруженых
	var _temp=target_Enemy.erase(dead_asteroid.ID)
	
	# отменить стрельбу пушек по умершему 
	_cancel_gun_fire(dead_asteroid)
	print("clear_array dead_Asteroid", _strr, "[ID: ", dead_asteroid.ID, "]")
func _get_available_guns() -> BasicGroundWeapons:
	#найти пушки, из них выбрать пушки который не стреляют
	var Weapons = get_tree().get_nodes_in_group("BasicGroundWeapons")
	var ready_guns = []
	
	for Weapon in Weapons:
		if !Weapon.get_is_shooting_Legal():
			ready_guns.append(Weapon)
		
	return ready_guns
func _validate_targets() -> Array:
	# нет обнаруженых целей
	if target_Enemy.size() < 1:
		return []
	
	for ID in target_Enemy.keys():
		if !is_instance_valid(target_Enemy[ID]):
			var _temp=target_Enemy.erase(ID)
			
	return target_Enemy.values()
func _cancel_gun_fire(dead_asteroid)->void:
	var Weapons = get_tree().get_nodes_in_group("Weapon")
	
	for d in Weapons:
		# если пушка не стреляет, пропускаем
		if !d.get_is_shooting_Legal():
			continue
		# если пушка стреляла по астероиду с тем же номером то сбрасывает цель стрельбы	
		if d.get_Enemie_id() == dead_asteroid.ID:
			d.set_Enemie(null)
#-------------------------------------------------------------------------------
func get_pool()->BassicPool:
	if poolBullet!=null:
		return poolBullet
	else:
		print("Error PoolBullet")
		return null
