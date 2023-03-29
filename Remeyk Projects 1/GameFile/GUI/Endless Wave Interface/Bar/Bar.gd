extends Control

onready var _Level = $Panel/MarginContainer/GridContainer/Num_Level

onready var _Gold_bar = $Panel/MarginContainer/GridContainer/Gold_Bar
onready var _Gold = $Panel/MarginContainer/GridContainer/Gold_Bar/Num_Gold

onready var Elixir_bar = $Panel/MarginContainer/GridContainer/Elixir_Bar
onready var _Elixir = $Panel/MarginContainer/GridContainer/Elixir_Bar/Num_Elixir

onready var Metal_bar = $Panel/MarginContainer/GridContainer/Metal_Bar
onready var _Metal = $Panel/MarginContainer/GridContainer/Metal_Bar/Num_Metal

onready var Hp_planet_bar = $Panel/MarginContainer/GridContainer/HP_Planet_Bar
onready var _HP = $Panel/MarginContainer/GridContainer/HP_Planet_Bar/Num_HP

onready var _Diamond = $Panel/MarginContainer/GridContainer/Num_Diamond

var max_Gold=100
var max_Elixir=100
var max_Metal=100
var max_HP:int=1

func _ready():
	print("in ready of name "+ $".".get_name())
	Events.connect("_HP_Planet_max",self,"set_max_HP")
	Events.connect("_HP_Planet",self,"update_HP")
	Globals.BAR=self
	update_level()
	update_gold(100)
	update_Elixir()
	update_Metal(100)
	update_Diamonds()
	pass 





#----------Level--------------------
func update_level(_level:int=1)->void:
	if _level>=int(_Level.get_text()):
		_Level.set_text(str(_level))
func get_level()->int:
	return int(_Level.get_text())
#-------------------------------------

#----------Gold-----------------------
func update_gold(_gold:int=0)->void:
	var Gold=int(_Gold.get_text())
	_Gold.set_text(str(Gold+_gold))
	_Gold_bar.set_value(int((float(_Gold.get_text())/max_Gold)*100))
func Buy_gun_Gold(_price:int)->void:
	update_gold(-_price)
func get_gold()->int:
	return int(_Gold.get_text())
func set_new_max_gold(_max_gold:int)->void:
	if _max_gold>max_Gold:
		max_Gold=_max_gold
#-------------------------------------

#----------Elixir---------------------
func update_Elixir(_elixir:int=0)->void:
	var Elixir=int(_Elixir.get_text())
	_Elixir.set_text(str(Elixir+_elixir))
	Elixir_bar.set_value(int((float(_Elixir.get_text())/max_Elixir)*100))
func Buy_gun_Elixir(_price:int)->void:
	update_Elixir(-_price)
func get_Elixir()->int:
	return int(_Elixir.get_text())
func set_new_max_Elixir(_max_Elixir:int)->void:
	if _max_Elixir>max_Elixir:
		max_Elixir=_max_Elixir
#-------------------------------------

#----------Metal---------------------
func update_Metal(_metal:int=0)->void:
	var Metal=int(_Metal.get_text())
	_Metal.set_text(str(Metal+_metal))
	Metal_bar.set_value(int((float(_Metal.get_text())/max_Metal)*100))
func Buy_gun_Metal(_price:int)->void:
	update_Metal(-_price)
func get_Metal()->int:
	return int(_Metal.get_text())
func set_new_max_Metal(_max_Metal:int)->void:
	if _max_Metal>max_Metal:
		max_Metal=_max_Metal
#-------------------------------------


#----------HP-------------------------
func update_HP(_hp:int=0)->void:
	if _hp>=0:
		_HP.set_text(str(_hp))
		Hp_planet_bar.set_value(int((float(_HP.get_text())/max_HP)*100))
func set_max_HP(_max_HP:int)->void:
	if _max_HP>0:
		max_HP=_max_HP
func get_HP()->int:
	return int(_HP.get_text())
#-------------------------------------

#----------Diamonds---------------------
func update_Diamonds(_diamonds:int=0)->void:
	if _diamonds>=0:
		var Diamond=int(_Diamond.get_text())
		_Diamond.set_text(str(Diamond+_diamonds))
func Buy_gun_Diamonds(_price:int)->void:
	update_Diamonds(-_price)
func get_Diamonds()->int:
	return int(_Diamond.get_text())
#-------------------------------------


func _Having_Money_G_M_(_G:int,_M:int,ID:Object)->bool:
	var money_G=get_gold()-_G>=0
	var money_M=get_Metal()-_M>=0
	if money_G and money_M:
		Buy_gun_Gold(_G)
		Buy_gun_Metal(_M)
		return true
	
	if !money_G:
		ID.not_G()
	if !money_M:
		ID.not_M()
	return false

func sell_the_gun(_G:int,_M:int):
	update_gold(_G)
	update_Metal(_M)
	pass
	
func have_money_to_level_up(_G:int,_M:int):
	var money_G=get_gold()-_G>=0
	var money_M=get_Metal()-_M>=0
	if money_G and money_M:
		Buy_gun_Gold(_G)
		Buy_gun_Metal(_M)
		return true
	else:
		return false
	pass
