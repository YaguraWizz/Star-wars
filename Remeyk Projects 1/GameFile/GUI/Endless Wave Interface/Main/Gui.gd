extends Control

var Visibility_Of_Settings:bool=false

var state:bool=true
func _ready():
	print("in ready of name "+ $".".get_name())



func _on_Settings_pressed():
	print("call grup")
	$Settings.Pause()

func _Visibility_Store():
	if state:
		state=false
		get_tree().call_group("Magazine","Panel_Animation",state)
	else:
		state=true
		get_tree().call_group("Magazine","Panel_Animation",state)
	pass
