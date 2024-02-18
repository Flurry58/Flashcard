extends HSlider


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_home_term_press():
	var val = 0
	if Globals.curindex > len(Globals.indlist):
		val = abs(Globals.curindex + 1) % (len(Globals.indlist))
	else:
		val = Globals.curindex + 1
	set_value_no_signal(val)
