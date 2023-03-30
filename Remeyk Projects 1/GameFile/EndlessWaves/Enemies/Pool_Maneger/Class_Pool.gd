extends Node

class_name Pool

export var Prefab:String
export var AutoExpand:bool=true
export var Transform_Container:Dictionary={}
export var pool:Dictionary={}


func _init(_Prefab:String,count:int):
	Prefab=_Prefab
	CreatePool(count)
	
#запускаем функцию заполнение словаря
func CreatePool(count:int)->void: 
	for i in range(count): 
		CreateObject(false,i)   #проходим по циклу вызывая функцию заполнения пула
		pass
		
		
func CreateObject(isActiveByDefault:bool=false,ID:int=0)->BassicEnemies:
	var _CreateObject=load(Prefab).instance()
	_CreateObject.setActive(isActiveByDefault) #Выключаем видимость
	pool[ID]=_CreateObject  #добавляем в словарь
	_CreateObject.spawn_id=ID
	#print("\npool[ID] ",pool[ID]," _CreateObject.spawn_id ",_CreateObject.spawn_id," ID ",ID)
	return _CreateObject
	
func HasFreeElement(): #функция по возврату скрытого объекта 
	for CreateObject in range(pool.size()):
		if !pool[CreateObject].getActive():
			pool[CreateObject].setActive(true)
			return pool[CreateObject]
			
	return null
			
func GetFreeElement():
	var element=HasFreeElement()
	if element!=null:
		#print("\nthere are free loop ",element)
		Events.emit_signal("_size_pool",("free obj pool size "+str(pool.size())))
		return element
	if AutoExpand:
		var temp=CreateObject(true,pool.size())
		#print("\nnew obj loop ",temp)
		Events.emit_signal("_size_pool",("new obj pool size "+str(pool.size())))
		return temp #если все скрытые заняты создаем новый
