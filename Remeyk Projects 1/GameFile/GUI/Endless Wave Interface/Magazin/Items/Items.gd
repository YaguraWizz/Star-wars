extends Panel

export var ID:int
export var _Path_Defender:String
export var Texture_With_Empty_Slot:Texture=load("res://GameFile/GUI/Endless Wave Interface/Magazin/img/Замок.png")

onready var _name = $MarginContainer/HBoxContainer/VBoxContainer/MarginContainer/CenterContainer/_Name
onready var _damag = $MarginContainer/HBoxContainer/VBoxContainer/GridContainer/Damag
onready var _type = $MarginContainer/HBoxContainer/VBoxContainer/GridContainer/Type
onready var _gold = $MarginContainer/HBoxContainer/VBoxContainer/GridContainer/Gold
onready var _metal = $MarginContainer/HBoxContainer/VBoxContainer/GridContainer/Metal
onready var _texture_rect = $MarginContainer/HBoxContainer/CenterContainer/TextureRect

onready var animation_player = $AnimationPlayer
onready var animation_player_2 = $AnimationPlayer2


var Ignore:bool=false
var _Obj:Object


func _ready():
	print("in ready of name "+ $".".get_name())
	Default_Values()
	if _Obj!=null:
		Events.emit_signal("_Comparison_Gun",_Obj)
		

func Default_Values()->void:
	_texture_rect.set_texture(Texture_With_Empty_Slot)

func set_ID(_ID:int=-1)->void:
	ID=_ID


func set_Info_Itom(obj:Object)->void:
	if obj!=null:
		_texture_rect.set_texture(load(obj.get_Texture()))
		_name.set_text(obj.get_Name())
		_damag.set_text(str(obj.get_Damage()))
		_type.set_text(obj.get_Type())
		_gold.set_text(str(obj.get_Gold()))
		_metal.set_text(str(obj.get_Metal()))
		_Obj=obj
	else:
		print("this is not a valid object :Items ")




func _buying_weapons():
	if (!Events._get_Buy_Item_Status() and _Obj!=null
	 and _Obj.get_Path_Weapons_is_valid() and Globals.BAR._Having_Money_G_M_(_Obj.get_Gold(),_Obj.get_Metal(),self)):
		
		var new_gun=load(_Obj.get_Path_Weapons()).instance()
		new_gun.set_data_filling(_Obj)
		Globals.Planets.add_child(new_gun)
		Events._set_Buy_Item_Status(true)
		#print(Globals.Skaner.position)
		#get_viewport().warp_mouse(Vector2(571,310))
	else:
		if Events._get_Buy_Item_Status():
			print("Purchase Error, You have already bought a weapon:Items ")
		elif _Obj==null:
			print("Purchase Error, Weapon object is null:Items ")
		elif _Obj.get_Path_Weapons_is_valid():
			print("Purchase Error, Weapon file path is not valid:Items ")
		elif Globals.BAR.money_check(_Obj.get_Gold(),_Obj.get_Metal(),self):
			print("Purchase Error, You don't have enough money:Items ")
		else:
			print("Purchase Error, Undefined error:Items ")
	
func not_G()->void:
	animation_player.play("Flashing1")
func not_M():
	animation_player_2.play("Flashing2")
	
	





func _on_Items_mouse_entered():
	if _Obj!=null and get_tree().get_nodes_in_group("Defender").size()>=1:
		Events.emit_signal("_Comparison_Gun",_Obj)
		Events._set_Performance_Comparison_Status(true)
	pass # Replace with function body.


func _on_Items_mouse_exited():
	Events._set_Performance_Comparison_Status(false)
	pass # Replace with function body.
