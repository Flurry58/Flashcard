extends Control

var error_sent = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if error_sent:
		set_process_input(true) 
	else:
		set_process_input(false) 

#when user cluicks anywhere on screen remove error message
func _input(ev):
	if ev.is_pressed():
		$Error.set_text("")
		error_sent = false
	
#uncheck the study starred checkbox
func _on_home_set_vis(val):
	$Study_Star.set_pressed_no_signal(val)

#set error message, mostly used for when attempting to study starred terms
#but there are no starred terms to currently study 
func _on_home_set_error(text):
	$Error.set_text(text)
	error_sent = true
