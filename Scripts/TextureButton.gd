extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready():
	if Globals.indlist[Globals.curindex] in Globals.starred_list:
		set_pressed_no_signal(true)
	else:
		set_pressed_no_signal(false)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.indlist[Globals.curindex] in Globals.starred_list:
		set_pressed_no_signal(true)
	else:
		set_pressed_no_signal(false)


func _on_toggled(button_pressed):
	Globals.set_star(Globals.indlist[Globals.curindex])
	
