extends Control


onready var margin_container = $Panel/MarginContainer
onready var tween = $Tween
onready var magazine = $"."

func Panel_Animation(state:bool)->void:
	if state:
		tween.interpolate_property(magazine,"rect_position:x",-225,25,0.25,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT,0)
		tween.start()
		#show()
	else:
		tween.interpolate_property(magazine,"rect_position:x",25,-225,0.25,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT,0)
		tween.start()
		#hide()

func _ready():
	print("in ready of name "+ $".".get_name())








