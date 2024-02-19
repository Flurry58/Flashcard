extends Node2D


signal term_press
signal change_max
signal set_error(text)

signal set_vis(val)
var curterm = ""
var val = 0
#set this node to be the only node to handle all sending signals about global values
var writing = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func put_new_term(text):
	$Term_Text.put_new(text)

func put_new_def(text):
	$Def_text.put_new(text)
	
func send_error(text):
	set_error.emit(text)
	
func change_vis():
	$Set_index.visible = true
	set_vis.emit(false)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_process_input(true) 
	if Globals.change_vis_signal:
		change_vis()
		send_error("No terms starred")
		Globals.change_vis_signal = false
	if Globals.run_change:
		curterm = Globals.indlist[Globals.curindex]
		change_max.emit()
		$Term_Text.put_new(curterm, true)
		$Def_text.put_new(Globals.flashcards[curterm], true)
		Globals.run_change = false
	#if the starred list is empty do not activate starred as there are no starred terms to go over yet
	if Globals.unset:
		$Set_index.visible = true
		Globals.normal_set()
		Globals.unset = false
	if Globals.n_press or Globals.b_press:
		term_press.emit()
		Globals.n_press = false
		Globals.b_press = false
	
	
	#handles keybinding inputs and plays animations accordingly, have to play animations BEFORE we call 
	#the $Flip_but._on_next_pressed() as that changes that value of Globals.flipped
func _input(ev):
	if writing == false:
		
		$TextEdit.clear()
		if Input.is_key_pressed(KEY_SPACE):
			if Globals.flipped:	
				$Node2D/AnimatedSprite2D.play("term")
				$Node2D/AnimatedSprite2D.set_frame_and_progress(0, 0)
				$Node2D/AnimatedSprite2D.pause()
				
			else:
				$Node2D/AnimatedSprite2D.play_backwards("flip")
				$Node2D/AnimatedSprite2D.set_frame_and_progress(0, 0)
				$Node2D/AnimatedSprite2D.pause()	

			Globals.flipped = not Globals.flipped
			Globals.dontrepeat = true
			print(Globals.flipped)
				
		elif Input.is_key_pressed(KEY_RIGHT):
			if Globals.flipped:
				$Node2D/AnimatedSprite2D.play("term")
				$Node2D/AnimatedSprite2D.set_frame_and_progress(0, 0)
				$Node2D/AnimatedSprite2D.pause()		
			$Flip_But._on_next_pressed()
			
		elif Input.is_key_pressed(KEY_LEFT):
			if Globals.flipped:
				$Node2D/AnimatedSprite2D.play("term")
				$Node2D/AnimatedSprite2D.set_frame_and_progress(0, 0)
				$Node2D/AnimatedSprite2D.pause()		
			$Flip_But._on_back_pressed()
			
#
#
#
func _on_check_box_toggled(button_pressed):
	Globals.start_randomize = not Globals.start_randomize

#
# When the mouse is inside the text edit box set the variable writing to true. This makes it so that
# we stop monoritng inputs and so when the space bar is pressed it does not call the function to flip the card
# but lets the user type a space
#		
func _on_text_edit_mouse_entered():
	writing = true
#
# When users mouse exists the box disable writing and turn back on input monoriting 
#	
func _on_text_edit_mouse_exited():
	writing = false
	
