extends Node2D

func _ready():
	$AnimationPlayer.play("Ded_anim")

# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_finished(anim):
	#queue_free()
	show()
