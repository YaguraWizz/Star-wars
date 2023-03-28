extends Control

onready var pl=$TextureRect
var angular_speed = PI
func _physics_process(_delta):
	pl.global_position=Vector2(OS.get_real_window_size().x/2,OS.get_real_window_size().y/2)
	pl.rotation_degrees += angular_speed * _delta
