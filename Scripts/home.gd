extends Node2D


signal term_press(n)
#set this node to be the only node to handle all sending signals about global values
var writing = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Set_index.max_value = len(Globals.indlist)
	$Set_index.min_value = 0

func put_new_term(text):
	$Term_Text.put_new(text)

func put_new_def(text):
	$Def_text.put_new(text)
	
#when unset is true then reset starred and put the study mode back to studying all the cards
func exit_starred():
	$Set_index.visible = true
	Globals.normal_set()
	Globals.unset = false
	
#if either the next button or back button is pressed emit a signal to notify other nodes of this action
#this is used to mainly manage animations and modify the position of certain nodes
func emit_signal_term():
	term_press.emit()
	Globals.n_press = false
	Globals.b_press = false
	
#
# change flashcard text, this is rarely used and only used mainly when a new json set is
# uploaded.

func force_change():
	$Set_index.max_value = len(Globals.indlist)-1
	var curterm = Globals.indlist[Globals.curindex]
	$Term_Text.put_new(curterm, true)
	$Def_text.put_new(Globals.flashcards[curterm], true)
	Globals.run_change = false
#

	
	
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
# when we toggle the study only starred button hide/show the set index scrollbar 
# if we are disabling the study starred only, then reset the stared and go back to normal 
# else enable starred using the star_only command
func _on_study_star_toggled(button_pressed):
	if Globals.currently_stared:
		$Set_index.visible = true
	#	print("Reset")
		Globals.normal_set()
	else:
		$Set_index.visible = false
		#print("Star Only")
		Globals.star_only = true

#
# When we stop dragging the Set_Index slider, set the current index to the number we landed on
#
func _on_set_index_drag_ended(value_changed):
	var val = int($Set_index.get_value())
	if Globals.indlist[val] != "*$%#%%":
		if Globals.curindex > len(Globals.indlist):
			Globals.curindex = abs(Globals.curindex) % (len(Globals.indlist))
		else:
			Globals.curindex = val
	else:
		Globals.curindex = abs(Globals.curindex + 1) % (len(Globals.indlist))
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
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_process_input(true) 
	if Globals.run_change:
		force_change()
	#if the starred list is empty do not activate starred as there are no starred terms to go over yet
	if Globals.unset:
		exit_starred()
		
	if Globals.n_press or Globals.b_press:
		emit_signal_term(Globals.n_press)
