extends Node2D


onready var PrefabEnemisAsteroids:String="res://MainFacilities/Enemies/AsteroidsAndComets/BasicAsteroids/BasicAsteroids.tscn"
var pool:BassicPool
var StartingNumberOfAsteroids:int=10
var CastomTimer=0
func _ready():
	print("ready of name BasicWeapon:"+ $".".get_name())
	pool=BassicPool.new(PrefabEnemisAsteroids,StartingNumberOfAsteroids)
	pass

func _process(delta):
	CastomTimer+=delta
	if CastomTimer>=6:
		var Asteroid=pool.GetFreeElement()
		if Asteroid==null:return
		Asteroid.position=get_start_position()
		Asteroid.set_Speed(90)
		Asteroid.Destination=Global.PLANET.global_position
		add_child(Asteroid)
		CastomTimer=0
	pass

func get_start_position()->Vector2:
	var window=OS.get_real_window_size()
	var x=randi()%4
	var new_position:Vector2=Vector2(rand_range(-window.x,window.x),window.y)
	match x:
			0:new_position=Vector2(rand_range(-1000,1000), rand_range(-1000,-800))
			1:new_position=Vector2(rand_range(-1000,1000), rand_range(1000,800))
			2:new_position=Vector2(rand_range(-1000,-800), rand_range(-1000,1000))
			3:new_position=Vector2(rand_range(1000,800), rand_range(-1000,1000))
#		0 :new_position=Vector2(rand_range(-window.x,window.x),window.y)
#		1 :new_position=Vector2(rand_range(-window.x,window.x),-window.y)
#		2 :new_position=Vector2(window.x,rand_range(-window.y,window.y))
#		3 :new_position=Vector2(-window.x,rand_range(-window.y,window.y))
	return new_position

func intercept_point(ca) -> Vector2: #вычисление точки пересечения траекторий астероида и пули (примерное)
	return ca.target_center_return() + Vector2(global_position.distance_to(ca.target_center_return())/2/ca.get_Speed()*ca.get_Speed(),
		0).rotated(ca.rotation)



## Установить глобальную рандомную позицию объекта вне экрана
#func set_random_position_outside_screen(object):
#    var screen_size = get_viewport_rect().size
#    var object_size = object.get_rect().size
#    var x = rand_range(-object_size.x, screen_size.x + object_size.x)
#    var y = rand_range(-object_size.y, -object_size.y * 2)
#    object.position = Vector2(x, y)
#
## Переместить объект к конечной точке
#func move_to_destination(destination):
#    var direction = (destination - position).normalized()
#    object.position += direction * speed * delta



