extends BassicEnemies

#--------Object Fields----------------------------------------------------------
onready var _Name:String = "Fiery_Asteroid"
onready var _Damag:float = 25.0
onready var _Speed:float = 1.0
onready var _Gold:int  = rand_range(0,3)
onready var _Metal:int = rand_range(0,3)
onready var _HP_Enemies:int = 40
#-------------------------------------------------------------------------------

func _ready():
	.set_Name(_Name)
	.set_Damag(_Damag)
	.set_Speed(_Speed)
	.set_Gold(_Gold)
	.set_Metal(_Metal)
	.set_HP_Enemies(_HP_Enemies)

