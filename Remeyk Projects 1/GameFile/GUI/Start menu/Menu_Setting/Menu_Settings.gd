extends Panel


var set_
func _on_Button_pressed():
	set_.hide()
	var _path = get_tree().change_scene("res://GameFile/EndlessWaves/Game/Endless Waves.tscn")



func _on_Button4_pressed():
	get_tree().quit()

