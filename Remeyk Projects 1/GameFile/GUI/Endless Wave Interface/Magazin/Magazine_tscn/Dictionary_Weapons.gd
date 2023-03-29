extends Node


onready var _Dictionary_Weapons = {}

onready var _Dictionary_Icon = {
	'0' : 'res://Images/Endless Waves/Defender/defender1/пушка 1.png',
	'1' : 'res://Images/Endless Waves/Defender/defender2/laser.png',
	'2' : 'res://Images/Endless Waves/Defender/defender1/пушка 1.png',
	'3' : 'res://Images/Endless Waves/Defender/defender1/пушка 1.png',
	'4' : 'res://Images/Endless Waves/Defender/defender2/laser.png',
	'5' : 'res://Images/Endless Waves/Defender/defender1/ракетница_1.png',
	'6' : 'res://Images/Endless Waves/Defender/defender1/пушка 1.png',
	'7' : 'res://Images/Endless Waves/Defender/defender1/пушка 1.png',
	'8' : 'res://Images/Endless Waves/Defender/defender1/пушка 1.png',
	'9' : 'res://Images/Endless Waves/Defender/defender1/пушка 1.png',
	'10' : 'res://Images/Endless Waves/Defender/defender1/пушка 1.png'
}
onready var _Dictionary_Bullet = {
	'0' : 'res://GameFile/EndlessWaves/Defender/AllDefender/Gun_Defender/Conventional_Bullets/DefoltBullets.tscn',
	'1' : '',
	'2' : 'res://GameFile/EndlessWaves/Defender/AllDefender/Plasma_Defender/Plasma_bullets/Plasma_bullets.tscn',
	'3' : 'res://GameFile/EndlessWaves/Defender/AllDefender/Railgun_Defender/Tungsten_Rod/Tungsten_rod_bullit.tscn',
	'4' : '',
	'5' : 'res://GameFile/EndlessWaves/Defender/AllDefender/Rocket_Launcher/Rocket_Bullet/Rocket_Bullet.tscn',
	'6' : 'res://GameFile/EndlessWaves/Defender/AllDefender/Energy_Defender/Energy_Bullet/Energy_Bullet.tscn',
	'7' : 'res://GameFile/EndlessWaves/Defender/AllDefender/Gun_Defender/Conventional_Bullets/DefoltBullets.tscn',
	'8' : 'res://GameFile/EndlessWaves/Defender/AllDefender/Mithril_Defender/Mithril_Bullet/Mithril_Bullet.tscn',
	'9' : 'res://GameFile/EndlessWaves/Defender/AllDefender/Adamantium_Defender/Adamantium_Bullet/Adamantium_Bullet.tscn',
	'10': 'res://GameFile/EndlessWaves/Defender/AllDefender/Orichalcum_Defender/Orichalcum_Bullet/Orichalcum_Bullet.tscn'

}
onready var _Dictionary_Path = {
	'0' : 'res://GameFile/EndlessWaves/Defender/AllDefender/Gun_Defender/Gun_Defender.tscn',
	'1' : 'res://GameFile/EndlessWaves/Defender/AllDefender/Laser_Defender/Laser_Defender.tscn',
	'2' : 'res://GameFile/EndlessWaves/Defender/AllDefender/Plasma_Defender/Plasma_Defender.tscn',
	'3' : 'res://GameFile/EndlessWaves/Defender/AllDefender/Railgun_Defender/Railgun_Defender.tscn',
	'4' : 'res://GameFile/EndlessWaves/Defender/AllDefender/Retarding_Laser/Retarding_Laser.tscn',
	'5' : 'res://GameFile/EndlessWaves/Defender/AllDefender/Rocket_Launcher/Rocket_Launcher.tscn',
	'6' : 'res://GameFile/EndlessWaves/Defender/AllDefender/Energy_Defender/Energy_Defender.tscn',
	'7' : 'res://GameFile/EndlessWaves/Defender/AllDefender/Speed_Defender/Seed_Defender.tscn',
	'8' : 'res://GameFile/EndlessWaves/Defender/AllDefender/Mithril_Defender/Mithril_Defender.tscn',
	'9' : 'res://GameFile/EndlessWaves/Defender/AllDefender/Adamantium_Defender/Adamantium_Defender.tscn',
	'10' : 'res://GameFile/EndlessWaves/Defender/AllDefender/Orichalcum_Defender/Orichalcum_Defender.tscn'
}	
onready var _Dictionary_Description = {
	'0' : 'обычная пушка \n стреляет средне',
	'1' : 'лазер довольно \n бысро работает \nс целью',
	'2' : 'плазма очень\n гарячая но ее \nмедлено делать',
	'3' : 'страрый добры \n метод всега \n надежный',
	'4' : 'замедляющий лазер \nдовольно сложный \nне но очень \nэффективный',
	'5' : 'ракет на планете \n много осталось \n почемубы и нет',
	'6' : 'энергетическая - \n энергия это сила',
	'7' : 'если быстро \n не значит сильно',
	'8' : 'мифическое \n оружие-дорогое',
	'9' : 'мифическое \n оружие-дорогое',
	'10': '',
}

class Weapons_class:
	var _ID:int
	var _Name:String
	var _Damage:float
	var _Speed:float
	var _Cooldown:float
	var _Type:String
	var _Gold:float
	var _Metal:float
	var _Texture:String
	var _Description:String
	var _bullet:PackedScene
	var _Path_Weapons:String
	var _Slowdown:float
	
	var _Path_Bullet_is_valid:bool
	var _Path_Weapons_is_valid:bool
	
	func _init(ID:int,Name:String,Damage:float,Speed:float,Cooldown:float,Type:String,Gold:float,Metal:float,Path_Weapons:String,bullet:String,__Texture:String,Description:String,Slowdown:float=0):
		if ID!=null:
			_ID=ID
			_Name=Name
			_Damage=Damage
			_Speed=Speed
			_Cooldown=Cooldown
			_Type=Type
			_Gold=Gold
			_Metal=Metal
			_Texture=__Texture
			_Description=Description
			_Slowdown=Slowdown
			
			if bullet.is_abs_path():
				_bullet=load(bullet)
				_Path_Bullet_is_valid=true
			else:
				_Path_Bullet_is_valid=false
				#print("Dictionary_Weapons, Weapons_class, is not bullet")
				
			if Path_Weapons.is_abs_path():
				_Path_Weapons=Path_Weapons
				_Path_Weapons_is_valid=true
			else:
				_Path_Weapons_is_valid=false
				#print("Dictionary_Weapons, Weapons_class, is not Path_Weapons")
			
	func get_ID()->int:
		return _ID
		
	func get_Name()->String:
		return _Name
	
	func get_Damage()->float:
		return _Damage
		
	func get_Speed()->float:
		return _Speed
		
	func get_Cooldown()->float:
		return _Cooldown
		
	func get_Type()->String:
		return _Type
	
	func get_Gold()->float:
		return _Gold
	
	func get_Metal()->float:
		return _Metal
	
	func get_Texture()->String:
		return _Texture
	
	func get_Description()->String:
		return _Description
		
	func get_Bullet()->PackedScene:
		return _bullet
		
	func get_Path_Weapons()->String:
		return _Path_Weapons

	func get_Slowdown()->float:
		return _Slowdown
		
	func get_Path_Bullet_is_valid()->bool:
		return _Path_Bullet_is_valid
		
	func get_Path_Weapons_is_valid()->bool:
		return _Path_Weapons_is_valid


func _ready():
	#print("in ready of name "+ $".".get_name())
	Globals.Globals_Dictionary_Weapons=self
	set_Dictionary_Weapons()
	Info_Itom_defender()

func set_Dictionary_Weapons()->void:
	_Dictionary_Weapons['0']=Weapons_class.new(0,'Default',0,0,0,'Default',0,0,'Default','Default',_Dictionary_Icon['0'],'Default')
	_Dictionary_Weapons[0]=Weapons_class.new(1,'Gun Defender',10.0,6.0,0.7,'Ordinary',10,10,_Dictionary_Path['0'],_Dictionary_Bullet['0'],_Dictionary_Icon['0'],_Dictionary_Description['0'])
	_Dictionary_Weapons[1]=Weapons_class.new(2,'Laser Defender',2.0,6.0,0.7,'Light',50,50,_Dictionary_Path['1'],'not bulet',_Dictionary_Icon['1'],_Dictionary_Description['1'])
	_Dictionary_Weapons[2]=Weapons_class.new(3,'Plasma Defender',20.0,6.0,1.0,'Plasma',25,25,_Dictionary_Path['2'],_Dictionary_Bullet['2'],_Dictionary_Icon['2'],_Dictionary_Description['2'])
	_Dictionary_Weapons[3]=Weapons_class.new(4,'Railgun Defender',10.0,6.0,0.9,'Railgun',30,30,_Dictionary_Path['3'],_Dictionary_Bullet['3'],_Dictionary_Icon['3'],_Dictionary_Description['3'])
	_Dictionary_Weapons[4]=Weapons_class.new(5,'Retarding Defender',0.1,6.0,0.7,'Slowdown',100,100,_Dictionary_Path['4'],'not bulet',_Dictionary_Icon['4'],_Dictionary_Description['4'],0.5)
	_Dictionary_Weapons[5]=Weapons_class.new(6,'Rocket Defender',100.0,6.0,1.0,'Rocket',150,150,_Dictionary_Path['5'],_Dictionary_Bullet['5'],_Dictionary_Icon['5'],_Dictionary_Description['5'])
	_Dictionary_Weapons[6]=Weapons_class.new(7,'Energy Defender',15.0,6.0,0.6,'Energy',200,200,_Dictionary_Path['6'],_Dictionary_Bullet['6'],_Dictionary_Icon['6'],_Dictionary_Description['6'])
	_Dictionary_Weapons[7]=Weapons_class.new(8,'Speed Defender',1.0,9.0,0.2,'Ordinary',120,120,_Dictionary_Path['7'],_Dictionary_Bullet['7'],_Dictionary_Icon['7'],_Dictionary_Description['7'])
	_Dictionary_Weapons[8]=Weapons_class.new(9,'Mithril Defender',20.0,6.0,0.6,'Mithril',500,500,_Dictionary_Path['8'],_Dictionary_Bullet['8'],_Dictionary_Icon['8'],_Dictionary_Description['8'])
	_Dictionary_Weapons[9]=Weapons_class.new(10,'Adamantium Defender',40.0,6.0,0.6,'Adamantium',700,700,_Dictionary_Path['9'],_Dictionary_Bullet['9'],_Dictionary_Icon['9'],_Dictionary_Description['9'])
	_Dictionary_Weapons[10]=Weapons_class.new(11,'Orichalcum Defender',60.0,6.0,0.6,'Orichalcum',1000,1000,_Dictionary_Path['10'],_Dictionary_Bullet['10'],_Dictionary_Icon['10'],_Dictionary_Description['10'])


func Info_Itom_defender():
	var Itoms = get_tree().get_nodes_in_group("Items")
	var _ID_ =_Dictionary_Weapons.size()-1
	if _ID_!=null  and Itoms!=null and Itoms.size()>0:
		for ID in range(Itoms.size()):
			if ID<_ID_:
				Itoms[ID].set_Info_Itom(_Dictionary_Weapons[ID])
			else:
				Itoms[ID].set_Info_Itom(_Dictionary_Weapons['0'])
	else:
		return null
	pass
	

