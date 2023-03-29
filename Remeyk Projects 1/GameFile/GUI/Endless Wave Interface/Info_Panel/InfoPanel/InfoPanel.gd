extends Control


#--------------_Icon------------------------------------------------

onready var _Icon = $Panel/MarginContainer/VBoxContainer/HBoxContainer/Icon
#-------------------------------------------------------------------
#------------_Name--------------------------------------------------
onready var _Name = $Panel/MarginContainer/VBoxContainer/_Name
#-------------------------------------------------------------------


#------------_Level-------------------------------------------------
onready var _Num_Level = $Panel/MarginContainer/VBoxContainer/MarginContainer/GridContainer/Num_Level
#-------------------------------------------------------------------

#--------------_Damage----------------------------------------------
onready var _Num_Damage = $Panel/MarginContainer/VBoxContainer/MarginContainer/GridContainer/Num_Damage
onready var color_rect = $Panel/MarginContainer/VBoxContainer/MarginContainer/GridContainer/Num_Damage/ColorRect


#-------------------------------------------------------------------

#-----------_type_of_damage-----------------------------------------
onready var _Num_type_of_damage = $Panel/MarginContainer/VBoxContainer/MarginContainer/GridContainer/Num_TypeOfDamage
#-------------------------------------------------------------------

#---------------_ds-------------------------------------------------
onready var _Num_ds = $Panel/MarginContainer/VBoxContainer/MarginContainer/GridContainer/Num_DS
onready var color_rect_3 = $Panel/MarginContainer/VBoxContainer/MarginContainer/GridContainer/Num_DS/ColorRect3

#-------------------------------------------------------------------

#-------------_Cooldown---------------------------------------------
onready var _Num_Cooldown = $Panel/MarginContainer/VBoxContainer/MarginContainer/GridContainer/Num_Cooldown
onready var color_rect_4 = $Panel/MarginContainer/VBoxContainer/MarginContainer/GridContainer/Num_Cooldown/ColorRect4
#-------------------------------------------------------------------

#-------------_Price------------------------------------------------
onready var _Num_Gold = $Panel/MarginContainer/VBoxContainer/MarginContainer/GridContainer/Num_Gold
onready var color_rect_5 = $Panel/MarginContainer/VBoxContainer/MarginContainer/GridContainer/Num_Gold/ColorRect5
#--------------------------------------------


#--------------------------------------------
onready var _Num_Metal = $Panel/MarginContainer/VBoxContainer/MarginContainer/GridContainer/Num_Metal
onready var color_rect_6 = $Panel/MarginContainer/VBoxContainer/MarginContainer/GridContainer/Num_Metal/ColorRect6
#-------------------------------------------------------------------

#-----------_Description--------------------------------------------
onready var _Description = $Panel/MarginContainer/VBoxContainer/Description
#-------------------------------------------------------------------
#-------------------------------------------------------------------
onready var start_size=$Panel/MarginContainer.get_size().y
#-------------------------------------------------------------------

#-------------------------------------------------------------------
onready var animation_player = $AnimationPlayer
onready var animation_player_2 = $AnimationPlayer2


#-------------------------------------------------------------------



#-----------------------------------------
onready var v_box_container = $Panel/MarginContainer/VBoxContainer
onready var _Panel=$Panel
onready var Info_Panel=$"."
onready var margin_container = $Panel/MarginContainer
var VBox=Vector2(200,302)
var Default_size_InfoPanelY:int=340
var Default_size_InfoPanelX:int=220
var timer:float=0
#-----------------------------------------

var Mounted_Weapons:Object
var Comparable_Weapon:Object
var oneshot:bool=false
var visible_:bool=false
var _Performance_Comparison_:bool=false

func _ready():
	Events.connect("_Info_Panel_",self,"_set_Info_Panel_")
	Events.connect("_Comparison_Gun",self,"_set_Comparable_Weapon")
	print("in ready of name "+ $".".get_name())





#----------ivent-info-panel--------------------
func _physics_process(_delta):
	timer+=_delta
	if timer>0.01 and visible_:
		timer=0
		castom_draw()
	if visible_:
		show()
	else:
		hide()
#----------------------------------------------
func castom_draw():
	var temp_str=_Description.get_text()
	_Description.set_text("")
	Info_Panel.set_custom_minimum_size(Vector2(Default_size_InfoPanelX,Default_size_InfoPanelY))
	Info_Panel._set_size(Vector2(Default_size_InfoPanelX,Default_size_InfoPanelY))
	_Panel.set_custom_minimum_size(Vector2(Default_size_InfoPanelX,Default_size_InfoPanelY))
	_Panel._set_size(Vector2(Default_size_InfoPanelX,Default_size_InfoPanelY))
	v_box_container._set_size(VBox)
	_Description.set_text(temp_str)
	_update_Panel()
#-------------------------------------------------------------------

#-------------------------------------------------------------------
func _update_Panel():
	var obj1=v_box_container.get_size()
	var obj2=margin_container
	var y:float=obj2.get_constant("margin_bottom")+obj2.get_constant("margin_top")+obj1.y
	#var x:float=obj2.get_parent_area_size().x
	var x:float=obj2.get_constant("margin_left")+obj2.get_constant("margin_right")+obj1.x
	var _size:Vector2=Vector2(x,y)

	Info_Panel.set_custom_minimum_size(_size)
	Info_Panel._set_size(_size)
	_Panel.set_custom_minimum_size(_size)
	_Panel._set_size(_size)
	if Events._get_Performance_Comparison_Status():
		Performance_Comparison()
	else:
		update_info()
#-------------------------------------------------------------------
#-------------------------------------------------------------------
func update_info():
	if visible_ and Mounted_Weapons!=null:
		_Icon.set_texture(Mounted_Weapons.get_Icon())
		_Name.set_text(Mounted_Weapons.get_Name())
		_Num_Level.set_text(str(Mounted_Weapons.get_Level()))
		_Num_Damage.set_text(str(Mounted_Weapons.get_Damage()))
		_Num_type_of_damage.set_text(str(Mounted_Weapons.get_Type_Of_Damage()))
		_Num_ds.set_text(str(Mounted_Weapons.get_Damage_per_second()))
		_Num_Cooldown.set_text(str(Mounted_Weapons.get_Cooldown()))
		_Num_Gold.set_text(str(Mounted_Weapons.get_Gold()))
		_Num_Metal.set_text(str(Mounted_Weapons.get_Metal()))
		_Description.set_text((Mounted_Weapons.get_Description()))
#-------------------------------------------------------------------


#------set-Info----------------------------
func _set_Info_Panel_(obj:Object)->void:
	if obj==null:return
	if  obj!=Mounted_Weapons:
		Mounted_Weapons=obj
		castom_draw()
		update_info()
		visible_=true
	else:
		Mounted_Weapons=null
		castom_draw()
		update_info()
		visible_=false
#----------------------------------------------
#----------------------------------------------
func _set_Comparable_Weapon(_Weapon:Object)->void:
	if _Weapon!=null:
		Comparable_Weapon=_Weapon
	else:
		print("Info Panel Error: _set_Comparable_Weapon-> _Weapon is null")
#----------------------------------------------
#----------------------------------------------
func Performance_Comparison()->void:
	if Comparable_Weapon==null or Mounted_Weapons==null:
		print("Mounted_Weapons ",Mounted_Weapons," Comparable_Weapon ",Comparable_Weapon)
		return
	
	_Icon.set_texture(Mounted_Weapons.get_Icon())
	_Name.set_text(Mounted_Weapons.get_Name())
	_Num_Level.set_text(str(Mounted_Weapons.get_Level()))
	if Mounted_Weapons.get_Damage()>=Comparable_Weapon.get_Damage():
		_Num_Damage.set_text(str(Mounted_Weapons.get_Damage())+" > "+str(Comparable_Weapon.get_Damage()))
		color_rect.set_frame_color(Color(0.27451, 0.862745, 0.47451, 0.47451))
		
	else:
		_Num_Damage.set_text(str(Mounted_Weapons.get_Damage())+" < "+str(Comparable_Weapon.get_Damage()))
		color_rect.set_frame_color(Color(0.862745, 0.27451, 0.7019, 0.47451))
		
	_Num_type_of_damage.set_text(str(Mounted_Weapons.get_Type_Of_Damage()))
	
	if Mounted_Weapons.get_Damage_per_second()>=(Comparable_Weapon.get_Damage()/Comparable_Weapon.get_Cooldown()):
		_Num_ds.set_text(str(Mounted_Weapons.get_Damage_per_second())+" > "+str(stepify(float(Comparable_Weapon.get_Damage()/Comparable_Weapon.get_Cooldown()),0.01)))
		color_rect_3.set_frame_color(Color(0.27451, 0.862745, 0.47451, 0.47451))
	else:
		_Num_ds.set_text(str(Mounted_Weapons.get_Damage_per_second())+" < "+str(stepify(float(Comparable_Weapon.get_Damage()/Comparable_Weapon.get_Cooldown()),0.01)))
		color_rect_3.set_frame_color(Color(0.862745, 0.27451, 0.7019, 0.47451))
		
		
	if Mounted_Weapons.get_Cooldown()>=Comparable_Weapon.get_Cooldown():
		_Num_Cooldown.set_text(str(Mounted_Weapons.get_Cooldown())+" > "+str(Comparable_Weapon.get_Cooldown()))
		color_rect_4.set_frame_color(Color(0.27451, 0.862745, 0.47451, 0.47451))
		
	else:
		_Num_Cooldown.set_text(str(Mounted_Weapons.get_Cooldown())+" < "+str(Comparable_Weapon.get_Cooldown()))
		color_rect_4.set_frame_color(Color(0.862745, 0.27451, 0.7019, 0.47451))
		
		
	if Mounted_Weapons.get_Gold()>=Comparable_Weapon.get_Gold():
		_Num_Gold.set_text(str(Mounted_Weapons.get_Gold())+" > "+str(Comparable_Weapon.get_Gold()))
		color_rect_5.set_frame_color(Color(0.27451, 0.862745, 0.47451, 0.47451))
		
	else:
		_Num_Gold.set_text(str(Mounted_Weapons.get_Gold())+" < "+str(Comparable_Weapon.get_Gold()))
		color_rect_5.set_frame_color(Color(0.862745, 0.27451, 0.7019, 0.47451))
		
		
	if Mounted_Weapons.get_Metal()==Comparable_Weapon.get_Metal():
		_Num_Metal.set_text(str(Mounted_Weapons.get_Metal())+" > "+str(Comparable_Weapon.get_Metal()))
		color_rect_6.set_frame_color(Color(0.27451, 0.862745, 0.47451, 0.47451))

	else:
		_Num_Metal.set_text(str(Mounted_Weapons.get_Metal())+" < "+str(Comparable_Weapon.get_Metal()))
		color_rect_6.set_frame_color(Color(0.862745, 0.27451, 0.7019, 0.47451))
	
	_Description.set_text(Mounted_Weapons.get_Description())
#-----------------------------------------------------------

#-----------------------------------------------------------
func _Level_Up():
	var is_there_money_to_increase_the_level=Globals.BAR.have_money_to_level_up(stepify(Mounted_Weapons.get_Gold()/2,1),stepify(Mounted_Weapons.get_Metal()/2,1))
	if Mounted_Weapons!=null and is_there_money_to_increase_the_level:
		Mounted_Weapons.up_Level()
	if !is_there_money_to_increase_the_level:
		animation_player.play("Flashing1")
		animation_player_2.play("Flashing2")
		
		
func not_G()->void:
	animation_player.play("Flashing1")
func not_M():
	animation_player_2.play("Flashing2")
#-----------------------------------------------------------

#-----------------------------------------------------------
func _Move():
	if Mounted_Weapons==null:return 
	Mounted_Weapons._set_is_dragMouse(true)
#-----------------------------------------------------------
#-----------------------------------------------------------

func _on_Button_pressed():
	Globals.BAR.sell_the_gun(Mounted_Weapons.get_Gold()/2,Mounted_Weapons.get_Metal()/2)
	visible_=false
	Mounted_Weapons=Mounted_Weapons.weapon_removal()
	pass # Replace with function body.
