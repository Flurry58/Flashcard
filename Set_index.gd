extends HSlider


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.n_press or Globals.b_press:
		set_value_no_signal(abs(Globals.curindex + 1) % (len(Globals.indlist)))
		
