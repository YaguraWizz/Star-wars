extends Node

var _Buy_Item_Status:bool=false
var _Active_Gun_Status:bool=false
var _Performance_Comparison:bool=false

#-------------------------------------------------
func _get_Buy_Item_Status()->bool:
	return _Buy_Item_Status
func _set_Buy_Item_Status(_Buy_Item_Status_)->void:
	_Buy_Item_Status=_Buy_Item_Status_
#-------------------------------------------------

#-------------------------------------------------
func _get_Active_Gun_Status()->bool:
	return _Active_Gun_Status
func _set_Active_Gun_Status(_Active_Gun_Status_)->void:
	_Active_Gun_Status=_Active_Gun_Status_
#-------------------------------------------------

#-------------------------------------------------
func _get_Performance_Comparison_Status()->bool:
	return _Performance_Comparison
func _set_Performance_Comparison_Status(_Performance_Comparison_)->void:
	_Performance_Comparison=_Performance_Comparison_
#-------------------------------------------------
#-------------------------------------------------

#----------Bar------------------------------------
signal _HP_Planet(now)
signal _HP_Planet_max(_max)
signal _Having_Money(_G,_M,Obj)
#-------------------------------------------------
#-------------------------------------------------
#-------------------------------------------------


#--------Info panel-------------------------------
signal _Info_Panel_(Gun)
signal _Comparison_Gun(Gun)
#-------------------------------------------------


#-------------------------------------------------
signal _GameOver()
#-------------------------------------------------
#-------------------------------------------------

signal _size_pool(size)
