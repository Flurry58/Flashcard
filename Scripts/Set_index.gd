extends HSlider

var val = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	max_value = len(Globals.indlist) - 1
	min_value = 0

func change_max():
	max_value = len(Globals.indlist)-1
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_home_term_press():
	set_value_no_signal(abs(Globals.curindex + 1) % (len(Globals.indlist)))


# When we stop dragging the Set_Index slider, set the current index to the number we landed on

func _on_drag_ended(value_changed):
	val = abs(int(get_value())) % (len(Globals.indlist))
	if Globals.indlist[val] != "*$%#%%":
		Globals.curindex = abs(val) % (len(Globals.indlist))
	else:
		Globals.curindex = abs(Globals.curindex + 1) % (len(Globals.indlist))


#
# when we toggle the study only starred button hide/show the set index scrollbar 
# if we are disabling the study starred only, then reset the stared and go back to normal 
# else enable starred using the star_only command
func _on_study_star_toggled(button_pressed):
	if Globals.currently_stared:
		visible = true
	#	print("Reset")
		Globals.normal_set()
	else:
		visible = false
		#print("Star Only")
		Globals.star_only = true
