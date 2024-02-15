extends Node2D

var writing = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Set_index.max_value = len(Globals.indlist)
	$Set_index.min_value = 0

func put_new_term(text):
	$Term_Text.put_new(text)

func put_new_def(text):
	$Def_text.put_new(text)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_process_input(true) 
	if Globals.run_change:
		$Set_index.max_value = len(Globals.indlist)-1
		var curterm = Globals.indlist[Globals.curindex]
		$Term_Text.put_new(curterm, true)
		$Def_text.put_new(Globals.flashcards[curterm], true)
		Globals.run_change = false
	#if the starred list is empty do not activate starred as there are no starred terms to go over yet
	if Globals.unset:
		$Set_index.visible = true
		Globals.normal_set()
		Globals.unset = false
	
	#handles keybinding inputs and plays animations accordingly, have to play animations BEFORE we call 
	#the $Flip_but._on_next_pressed() as that changes that value of Globals.flipped
func _input(ev):
	if writing == false:
		$TextEdit.clear()
		if Input.is_key_pressed(KEY_SPACE):
			$Flip_But._on_button_pressed()
			$Node2D._on_button_pressed()
			print(Globals.flipped)
		elif Input.is_key_pressed(KEY_RIGHT):
			if Globals.flipped:
				$Node2D/AnimatedSprite2D.play_backwards("flip")
			$Flip_But._on_next_pressed()
			
		elif Input.is_key_pressed(KEY_LEFT):
			if Globals.flipped:
				$Node2D/AnimatedSprite2D.play_backwards("flip")
			$Flip_But._on_back_pressed()
			

func _on_check_box_toggled(button_pressed):
	Globals.start_randomize = not Globals.start_randomize


func _on_study_star_toggled(button_pressed):
	if Globals.currently_stared:
		$Set_index.visible = true
	#	print("Reset")
		Globals.normal_set()
	else:
		$Set_index.visible = false
		#print("Star Only")
		Globals.star_only = true


func _on_set_index_drag_ended(value_changed):
	var val = int($Set_index.get_value())
	if Globals.indlist[val] != "*$%#%%":
		Globals.curindex = val
	else:
		Globals.curindex = abs(Globals.curindex + 1) % (len(Globals.indlist))
		
func _on_text_edit_mouse_entered():
	if Globals.flipped:
		writing = true
	
func _on_text_edit_mouse_exited():
	if Globals.flipped:
		writing = false
	
