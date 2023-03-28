extends Control

onready var label = $Label
onready var text_Pause:String="Pause"
onready var text_Game_Over:String="Game Over"
func _ready():
	Events.connect("_GameOver",self,"GameOver")
	print("in ready of name "+ $".".get_name())
	hide()


	
func _on_Button_pressed(_Button):
	if _Button==0:
		pass
	elif _Button==1:
		Pause()
		get_tree().change_scene("res://GameFile/GUI/Start menu/Main_Menu.tscn")
		pass
	pass

func _on_TextureButton_pressed():
	Pause()

func Pause():
	var new_pause_state=not get_tree().paused
	get_tree().paused=new_pause_state
	label.set_text(text_Pause)
	label.visible=new_pause_state
	visible=new_pause_state

func GameOver():
	$Panel/MarginContainer/VBoxContainer/HBoxContainer/TextureButton.disconnect("pressed",self,"_on_TextureButton_pressed")
	var new_pause_state=not get_tree().paused
	get_tree().paused=new_pause_state
	label.set_text(text_Game_Over)
	label.visible=new_pause_state
	visible=new_pause_state
	pass


func _on_For_The_Tester_pressed():
	pass # Replace with function body.
