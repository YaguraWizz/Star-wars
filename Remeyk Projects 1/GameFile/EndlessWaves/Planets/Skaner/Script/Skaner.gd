extends Area2D

var target_asteroids:Dictionary = {}
onready var sprite = $Sprite
var cols=0
var possitiun_defendr:Vector2


func _ready():
	print("in ready of name "+ $".".get_name())
	Globals.Skaner=self
	
func _process(delta):
	sprite.rotation+=delta*0.5
	_fire_defenders()
	
func _on_Skaner_area_entered(area):
	target_asteroids[area.spawn_id] = area
	#print("Scanner_area Defender count ", get_tree().get_nodes_in_group("Defender").size())
	#print("area.spawn_id: ", area.spawn_id)
	
	
func clear_target_array(dead_asteroid,_strr:String):
	# убрать мертвый астероид из листа обнаруженых
	var _temp=target_asteroids.erase(dead_asteroid.spawn_id)
	
	# отменить стрельбу пушек по умершему 
	_cancel_gun_fire(dead_asteroid)
	
	#print("clear_array dead_Asteroid", strr, "[spawn_id: ", dead_asteroid.spawn_id, "]")
	
func _fire_defenders():
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
		gun.set_Asteroid(target)
		
	return

func _get_available_guns() -> BassicDefender:
	#найти пушки, из них выбрать пушки который не стреляют
	var defenders = get_tree().get_nodes_in_group("Defender")
	var ready_guns = []
	
	for defender in defenders:
		if !defender.Fire:
			ready_guns.append(defender)
		
	return ready_guns


func _validate_targets() -> Array:
	# нет обнаруженых целей
	if target_asteroids.size() < 1:
		return []
	
	for spawn_id in target_asteroids.keys():
		if !is_instance_valid(target_asteroids[spawn_id]):
			var _temp=target_asteroids.erase(spawn_id)
			
		
	return target_asteroids.values()

func _cancel_gun_fire(dead_asteroid):
	var defenders = get_tree().get_nodes_in_group("Defender")
	
	for d in defenders:
		# если пушка не стреляет, пропускаем
		if !d.Fire:
			continue
		# если пушка стреляла по астероиду с тем же номером то сбрасывает цель стрельбы	
		if d.get_asteroid_id() == dead_asteroid.spawn_id:
			d.set_Asteroid(null)
