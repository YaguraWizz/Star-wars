extends Label


func _ready():
	Events.connect("_size_pool",self,"text_up")
	
func text_up(text):
	$".".set_text(text)
	pass
