extends Label


func _ready():
	Events.connect("_size_pool",self,"size_pool")
	pass 


func size_pool(str_num):
	$".".text=str_num
