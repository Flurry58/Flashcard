extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.flipped:
		position = Vector2(632,248)
	else:
		position = Vector2(624,312)
	if Globals.just_staring:
		_on_next_pressed()


func _on_button_pressed():
	Globals.flipped = not Globals.flipped


func _on_next_pressed():
	Globals.curindex = abs(Globals.curindex + 1) % (len(Globals.indlist))
	if Globals.indlist[Globals.curindex] == "*$%#%%":
		Globals.curindex = abs(Globals.curindex + 1) % (len(Globals.indlist))
	
	Globals.n_press = true
	if Globals.flipped:
		Globals.flipped = not Globals.flipped


func _on_back_pressed():
	Globals.b_press = true
	
	Globals.curindex = abs(Globals.curindex - 1) % (len(Globals.indlist))
	if Globals.indlist[Globals.curindex] == "*$%#%%":
		Globals.curindex = abs(Globals.curindex - 1) % (len(Globals.indlist))
	if Globals.flipped:
		Globals.flipped = not Globals.flipped
	
