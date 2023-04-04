extends Node
class_name BassicPool
export var Prefab:String
export var AutoExpand:bool=false
export var pool:Dictionary={}


func _init(_Prefab:String="",count:int=0):
	if !_Prefab.is_abs_path():
		#print("Error class WeaponElementPool: _Path_Weapon_Element is not a path")
		return null
	#print(Prefab)
	Prefab=_Prefab
	CreatePool(count)
	
#запускаем функцию заполнение словаря
func CreatePool(count:int)->void: 
	for i in range(count): 
		var _temp=CreateObject(false,i)   #проходим по циклу вызывая функцию заполнения пула
		pass
		
		
func CreateObject(isActiveByDefault:bool=false,ID:int=0)->Object:
	var _CreateObject=load(Prefab).instance()
	_CreateObject._set_is_it_an_active_object(isActiveByDefault) #Выключаем видимость
	pool[ID]=_CreateObject  #добавляем в словарь
	_CreateObject.ID=ID
	#print("\npool[ID] ",pool[ID]," _CreateObject._ID ",_CreateObject._ID," ID ",ID)
	return _CreateObject
	
func HasFreeElement(): #функция по возврату скрытого объекта 
	for CreateObject in range(pool.size()):
		if !pool[CreateObject]._get_is_it_an_active_object():
			pool[CreateObject]._set_is_it_an_active_object(true)
			return pool[CreateObject]
			
	return null
			
func GetFreeElement():
	var element=HasFreeElement()
	if element!=null:
		#print("\nthere are free loop ",element," pool.size() ",pool.size()," element._ID ",element.ID)
		return element
	if AutoExpand:
		var temp=CreateObject(true,pool.size())
		#print("\nnew obj loop ",temp," pool.size() ",pool.size()," temp._ID ",temp._ID)
		return temp #если все скрытые заняты создаем новый
		
