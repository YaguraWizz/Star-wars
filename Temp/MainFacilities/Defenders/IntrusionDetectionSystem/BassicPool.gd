extends Node
class_name BassicPool
export var Prefab:String
export var AutoExpand:bool=false
export var pool:Dictionary={}
var ID:int

func _init(_Prefab:String="",count:int=0):
	ID=get_instance_id()
	if !_Prefab.is_abs_path():
		print("Error class WeaponElementPool: _Path_Weapon_Element is not a path")
		return null
	Prefab=_Prefab
	for i in range(count): 
		var _temp=CreateObject(false,i)   #проходим по циклу вызывая функцию заполнения пула
		print("CreateObject ",pool[i])


func CreateObject(isActiveByDefault:bool=false,ID_:int=0)->Object:
	var _CreateObject=load(Prefab).instance()
	_CreateObject._set_is_it_an_active_object(isActiveByDefault) #Выключаем видимость
	pool[ID_]=_CreateObject  #добавляем в словарь
	_CreateObject.ID=ID_
	#print("\npool[ID] ",pool[ID]," _CreateObject._ID ",_CreateObject._ID," ID ",ID)
	return _CreateObject
	
func HasFreeElement(): #функция по возврату скрытого объекта 
	for CreateObject in range(pool.size()):
		if !pool[CreateObject]._get_is_it_an_active_object():
			pool[CreateObject]._set_is_it_an_active_object(true)
			return pool[CreateObject]
			
	return null
			
func GetFreeElement():
	var Obj=HasFreeElement()
	if Obj!=null:
		#print("\nthere are free loop ",element," pool.size() ",pool.size()," element.ID ",element.ID)
		return Obj
	if AutoExpand:
		var temp=CreateObject(true,pool.size())
		#print("\nnew obj loop ",temp," pool.size() ",pool.size()," temp._ID ",temp._ID)
		return temp #если все скрытые заняты создаем новый
		
func get_size_pool()->int:
	return pool.size()
